#' # Darwin Core mapping for occurrence dataset
#' 
#' Lien Reyserhove, Dimitri Brosens, Peter Desmet
#' 
#' `r Sys.Date()`
#'
#' This document describes how we map the occurrence data to Darwin Core.
#' 
#' ## Setup
#' 
#+ configure_knitr, include = FALSE
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

#' Set locale (so we use UTF-8 character encoding):
# This works on Mac OS X, might not work on other OS
Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

#' Load libraries:
library(tidyverse) # For data transformations

# None core tidyverse packages:
library(magrittr)  # For %<>% pipes

# Other packages
library(janitor)   # For cleaning input data
library(knitr)     # For nicer (kable) tables

#' Set file paths (all paths should be relative to this script):
raw_data_file = "../data/raw/alien_macroinvertebrates_occurrences.tsv"
dwc_occurrence_file = "../data/processed/dwc_occurrence/occurrence.csv"

#' ## Read data
#' 
#' Read the source data:
raw_data <- read.table(raw_data_file, header = TRUE, sep = "\t", quote="", fileEncoding = "UTF-8-BOM") 

#' Clean data somewhat: remove empty rows if present
raw_data %<>%  remove_empty_rows() 

#' Add prefix `raw_` to all column names. Although the column names already contain Darwin Core terms, new columns will have to be added between the current columns. To put all columns in the right order, it is easier to create new columns (some of them will be copies of the columns in the raw dataset) and then remove the columns of the raw occurrence dataset:
colnames(raw_data) <- paste0("raw_", colnames(raw_data))

#' Save those column names as a list (makes it easier to remove them all later):
raw_colnames <- colnames(raw_data)

#' Preview data:
kable(head(raw_data))

#' ## Create occurrence core
#' 
#' ### Pre-processing
occurrence <- raw_data

#' ### Term mapping
#' 
#' Map the source data to [Darwin Core Occurrence](http://rs.gbif.org/core/dwc_occurrence_2015-07-02.xml) (but in the classic Darwin Core order):
#' 
#' #### type
occurrence %<>% mutate(type = "Event")
#' 
#' #### modified
#' #### language
occurrence %<>% mutate(language = "en")

#' #### license
occurrence %<>% mutate(license = "http://creativecommons.org/publicdomain/zero/1.0/")

#' #### rightsHolder
occurrence %<>% mutate(rightsHolder = "Ugent; Aquatic ecolo")

#' #### accessRights
occurrence %<>% mutate(accessRights = "http://www.inbo.be/en/norms-for-data-use")

#' #### bibliographicCitation
#' #### references
#' #### institutionID
#' #### collectionID
#' #### datasetID
occurrence %<>% mutate(datasetID = "https://doi.org/10.15468/xjtfoo")

#' #### institutionCode
occurrence %<>% mutate(institutionCode = "INBO")
#' #### collectionCode
#' #### datasetName
occurrence %<>% mutate(datasetName = "Alien macroinvertebrates in Flanders, Belgium")

#' #### ownerInstitutionCode
#' #### basisOfRecord
occurrence %<>% mutate(basisOfRecord = "HumanObservation")

#' #### informationWithheld
#' #### dataGeneralizations
#' #### dynamicProperties
#' 
#' ---
#' 
#' #### occurrenceID
occurrence %<>% mutate(occurrenceID = raw_occurrenceID)

#' #### catalogNumber
#' #### recordNumber
#' #### recordedBy
occurrence %<>% mutate(recordedBy = raw_recordedBy)

#' #### individualCount
#' #### organismQuantity
#' #### organismQuantityType
#' #### sex
#' #### lifeStage
#' #### reproductiveCondition
#' #### behavior
#' #### establishmentMeans
#' #### occurrenceStatus
#' #### preparations
#' #### disposition
#' #### associatedMedia
#' #### associatedReferences
#' #### associatedSequences
#' #### associatedTaxa
#' #### otherCatalogNumbers
occurrence %<>% mutate(otherCatalogNumbers = raw_otherCatalogNumbers)

#' #### occurrenceRemarks
#' 
#' ---
#' 
#' #### organismID
#' #### organismName
#' #### organismScope
#' #### associatedOccurrences
#' #### associatedOrganisms
#' #### previousIdentifications
#' #### organismRemarks
#' 
#' ---
#' 
#' #### materialSampleID
#' 
#' ---
#' 
#' #### eventID
#' #### parentEventID
#' #### fieldNumber
#' #### eventDate
occurrence %<>% mutate(eventDate = raw_eventDate)

#' #### eventTime
#' #### startDayOfYear
#' #### endDayOfYear
#' #### year
#' #### month
#' #### day
#' #### verbatimEventDate
occurrence %<>% mutate(verbatimEventDate = raw_eventDate)

#' #### habitat
#' #### samplingProtocol
#' #### sampleSizeValue
#' #### sampleSizeUnit
#' #### samplingEffort
#' #### fieldNotes
#' #### eventRemarks
#' 
#' ---
#' 
#' #### locationID
#' #### higherGeographyID
#' #### higherGeography
#' #### continent
occurrence %<>% mutate(continent = "Europe")

#' #### waterBody
#' #### islandGroup
#' #### island
#' #### country
#' #### countryCode
occurrence %<>% mutate(countryCode = "BE")

#' #### stateProvince
#' #### county
#' #### municipality
occurrence %<>% mutate(municipality = raw_municipality)

#' #### locality
#' #### verbatimLocality
occurrence %<>% mutate(verbatimLocality = raw_verbatimLocality)

#' #### minimumElevationInMeters
#' #### maximumElevationInMeters
#' #### verbatimElevation
#' #### minimumDepthInMeters
#' #### maximumDepthInMeters
#' #### verbatimDepth
#' #### minimumDistanceAboveSurfaceInMeters
#' #### maximumDistanceAboveSurfaceInMeters
#' #### locationAccordingTo
#' #### locationRemarks
#' #### decimalLatitude
occurrence %<>% mutate(decimalLatitude = raw_decimalLatitude)

#' #### decimalLongitude
occurrence %<>% mutate(decimalLongitude = raw_decimalLongitude)

#' #### geodeticDatum
occurrence %<>% mutate(geodeticDatum = "WGS84")

#' #### coordinateUncertaintyInMeters
occurrence %<>% mutate(coordinateUncertaintyInMeters = raw_coordinateUncertaintyInMeters)

#' #### coordinatePrecision
#' #### pointRadiusSpatialFit
#' #### verbatimCoordinates
#' #### verbatimLatitude
occurrence %<>% mutate(verbatimLatitude = raw_verbatimLatitude)

#' #### verbatimLongitude
occurrence %<>% mutate(verbatimLongitude = raw_verbatimLongitude)

#' #### verbatimCoordinateSystem
occurrence %<>% mutate(verbatimCoordinateSystem = "Belgium Lambert 72")

#' #### verbatimSRS
occurrence %<>% mutate(verbatimSRS = "Belgium Datum 1972")

#' #### footprintWKT
#' #### footprintSRS
#' #### footprintSpatialFit
#' #### georeferencedBy
#' #### georeferencedDate
#' #### georeferenceProtocol
#' #### georeferenceSources
#' #### georeferenceVerificationStatus
#' #### georeferenceRemarks
#' 
#' ---
#' 
#' #### geologicalContextID
#' #### earliestEonOrLowestEonothem
#' #### latestEonOrHighestEonothem
#' #### earliestEraOrLowestErathem
#' #### latestEraOrHighestErathem
#' #### earliestPeriodOrLowestSystem
#' #### latestPeriodOrHighestSystem
#' #### earliestEpochOrLowestSeries
#' #### latestEpochOrHighestSeries
#' #### earliestAgeOrLowestStage
#' #### latestAgeOrHighestStage
#' #### lowestBiostratigraphicZone
#' #### highestBiostratigraphicZone
#' #### lithostratigraphicTerms
#' #### group
#' #### formation
#' #### member
#' #### bed
#' 
#' ---
#' 
#' #### identificationID
#' #### identificationQualifier
#' #### typeStatus
#' #### identifiedBy
occurrence %<>% mutate(identifiedBy = raw_identifiedBy)

#' #### dateIdentified
#' #### identificationReferences
#' #### identificationVerificationStatus
#' #### identificationRemarks
#' 
#' ---
#' 
#' #### taxonID
#' #### scientificNameID
#' #### acceptedNameUsageID
#' #### parentNameUsageID
#' #### originalNameUsageID
#' #### nameAccordingToID
#' #### namePublishedInID
#' #### taxonConceptID
#' #### scientificName
occurrence %<>% mutate(scientificName = raw_scientificName)

#' #### acceptedNameUsage
#' #### parentNameUsage
#' #### originalNameUsage
#' #### nameAccordingTo
#' #### namePublishedIn
#' #### namePublishedInYear
#' #### higherClassification
#' #### kingdom
occurrence %<>% mutate(kingdom = "Animalia")

#' #### phylum
#' #### class
#' #### order
#' #### family
#' #### genus
#' #### subgenus
#' #### specificEpithet
#' #### infraspecificEpithet
#' #### taxonRank
occurrence %<>% mutate(taxonRank = raw_taxonRank)

#' #### verbatimTaxonRank
#' #### scientificNameAuthorship
occurrence %<>% mutate(scientificNameAuthorship = raw_scientificNameAuthorship)

#' #### vernacularName 
#' #### nomenclaturalCode
occurrence %<>% mutate(nomenclaturalCode = "ICZN")

#' #### taxonomicStatus
#' #### nomenclaturalStatus
#' #### taxonRemarks
#' 
#' ### Post-processing
#' 
#' Remove the original columns:
occurrence %<>% select(-one_of(raw_colnames))

#' Preview data:
kable(head(occurrence))

#' Save to CSV:
write.csv(occurrence, file = dwc_occurrence_file, na = "", row.names = FALSE, fileEncoding = "UTF-8")

#' ## Summary
#' 
#' ### Number of records
#' 
#' * Source file: `r nrow(raw_data)`
#' * Occurrence core: `r nrow(occurrence)`
#'
#' ### Occurrence core
#' 
#' Number of duplicates: `r anyDuplicated(occurrence[["occurrenceID"]])` (should be 0)
#' 
#' The following numbers are expected to be the same:
#' 
#' * Number of records: `r nrow(occurrence)`
#' * Number of distinct `occurrenceID`: `r n_distinct(occurrence[["occurrenceID"]], na.rm = TRUE)`