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

postscript('raised-ranch.ps',
           horizontal = FALSE, onefile = FALSE, paper = 'special',
           width = 16.5, height = 11.7)

par(family = 'HersheySans', las = 1)
plot(assessed_total_2014 ~ year_built,
     main = 'Raised ranch houses in Scarsdale',
     xlab = 'Year built',
     ylab = '',
     type = 'n',
     xlim = c(1950, 1985),
     ylim = c(.8 * min(raised.ranch$assessed_total_2014), max(raised.ranch$assessed_total_2014)),
     bty = 'n',
     axes = F,
     font.main = 2, font.lab = 2,
     sub = 'Chernoff faces represent architectural styles.',
     data = raised.ranch)

axis(1, at = seq(1955, 1980, 5))
axis(2, at = seq(8e5, 18e5, 2e5), line = -4,
     labels = paste0('$', c('800', '1,000', '1,200', '1,400', '1,600', '1,800'), ',000'))

text(1950, max(raised.ranch$assessed_total_2014),
     font = 2,
     'Preliminary 2014 assessed value', xpd = TRUE)

f <- faces(raised.ranch[architecture], plot.faces = FALSE,
           ncolors = 8, labels = raised.ranch$property_number)

plot.faces(f, raised.ranch$year_built, raised.ranch$assessed_total_2014,
           face.type = 0,
           width = ceiling((max(raised.ranch$year_built) - min(raised.ranch$year_built)) / sqrt(nrow(raised.ranch))),
           height = ceiling((max(raised.ranch$assessed_total_2014) - min(raised.ranch$assessed_total_2014)) / sqrt(nrow(raised.ranch))))

dev.off()
