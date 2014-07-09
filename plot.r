install <- function() {
  if (!require(devtools)) {
    install.packages(devtools)
    library(devtools)
  }
  install_github('scarsdale_assessment_database','tlevine')
}

if (!require(scarsdale)) { install(); library(scarsdale) }
library(aplpack)

if (!('properties' %in% ls())) {
  properties <- query('select * from properties;')
  write.csv(properties, file = 'properties.csv', row.names = FALSE)
}

assessment   <- c('assessed_land_2014', 'assessed_land_2013_fmv', 'assessed_land_2013',
                  'assessed_total_2014', 'assessed_total_2013_fmv', 'assessed_total_2013',
                  'taxable_village', 'taxable_school', 'taxable_county',
                  'taxable_bronx_sewer', 'taxable_mamaroneck_sewer')

architecture <- c('bathrooms', 'bedrooms', 'fireplaces',
                  'central_air', 'living_area', 'no_stories',
                  'half_bathrooms')

for (column in architecture) {
  properties[,column] <- as.numeric(properties[,column])
}
properties$year_built <- as.numeric(properties$year_built)
properties$bldg_style_code <- sub(' .*', '', properties$bldg_style)
properties$zoning <- gsub('  *A?', '', properties$zoning)

# zoning
# year_built
# acreage

raised.ranch <- subset(properties, bldg_style_code == '02')
raised.ranch$zoning <- factor(raised.ranch$zoning)

postscript('raised-ranch.ps', width = 16.5, height = 11.7)

plot(assessed_total_2014 ~ year_built,
     main = 'Raised ranch houses in Scarsdale',
     xlab = 'Year built',
     ylab = '',
     type = 'n', las = 1,
     xlim = c(1950, 1985),
     ylim = c(.8 * min(raised.ranch$assessed_total_2014), max(raised.ranch$assessed_total_2014)),
     bty = 'n',
     data = raised.ranch)

text(1950, max(raised.ranch$assessed_total_2014),
     'Preliminary 2014\nassessed value', xpd = TRUE)

f <- faces(raised.ranch[architecture], plot.faces = FALSE,
           ncolors = 8, labels = raised.ranch$property_number)

plot.faces(f, raised.ranch$year_built, raised.ranch$assessed_total_2014,
           width = ceiling((max(raised.ranch$year_built) - min(raised.ranch$year_built)) / sqrt(nrow(raised.ranch))),
           height = ceiling((max(raised.ranch$assessed_total_2014) - min(raised.ranch$assessed_total_2014)) / sqrt(nrow(raised.ranch))))

dev.off()
