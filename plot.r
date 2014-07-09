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

# zoning
# year_built
# acreage

plot(half_bathrooms ~ year_built,
     data = subset(properties, property_class == "210 Single Res"))

# write.csv(properties, file = 'properties.csv', row.names = FALSE)
