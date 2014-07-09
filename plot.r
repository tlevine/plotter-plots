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
raised.ranch$cex <- sqrt(acreage) * 5


f <- faces(raised.ranch[architecture], plot.faces = FALSE)
plot(assessed_total_2014 ~ year_built,
     col = zoning, cex = cex,
     main = 'Raised ranch houses in Scarsdale',
     xlab = 'Year built',
     ylab = 'Preliminary 2014 assessed value',
     type = 'n',
     data = raised.ranch)
legend('topright', title = 'Zoning',
       levels(raised.ranch$zoning),
       col = 1:length(levels(raised.ranch$zoning)), pch = 1)

# write.csv(properties, file = 'properties.csv', row.names = FALSE)
