# Data Types in SQL
# - String Type
# - Numeric Type
# - Date and Time Types
# - Blob Types
# - Spatial Types

# Strings

# Char(X)
# VarChar(x) max: 65,535 characters (~64kb)
# MediumText max: 16mb
# LONGTEXT: MAX: 4GB
# TinyText: max: 255 bytes
# Text: max: 64kb
# e.g. varchar(50) for short strings
# varchar(255) for medium-length strings
# English take 1 byte for each character
# Middle East take 2 byte for each character
# Asian like chinese and Japaneses take 3 bytes


# Integer
# TinyByte 1b [-128, 127]
# Unsigned TinyInt [0,255]
# Small Int 2b [-32k, 32k]
# Medium Int 3b
# Int 4b
# Big Int 8b

# Fixed Point and Floating Point
# Decimal(p,s)
# Dec
# Numeric
# Fixed
# Float 4b
# Double 8b

# Booleans
# Bool
# Boolean
# True or False synonyms for 1 and 0

# Enums
# Enum (small, medium, large)
# Try to Create lookup table
# Set type is also similar to enums

# Data / Time
# Date
# Time
# DateTime (use this type of time)
# TimeStamp 4b (up to 2038)
# Year

# Blob types
# we use blob types to save large amount of data like images, videos, pdfs and binary data
# Four Types
# TinyBlob 255b
# Blob 65kb
# Medium Blob 16mb
# Long Blob 4gb
# Problems with storing files in a database
# Increased database size
# slower backups
# performance problems
# More code to read/write images


# JSON Type / Documents
# Lightweight format for storing and transforming data over the internet.
# json
# {
#   "key" : "value"
#  }

select * from products;

update products set properties =
    '
{
"dimensions": [1,2,3],
"weight": 22,
"manufecture": {
"name": "Sony"
}

}
' where product_id = 1;


update products set properties = JSON_OBJECT(
    'WEIGHT', 10,
    'DIMENSIONS', JSON_ARRAY(1,2,3),
    'MANUFACTURE', JSON_OBJECT('NAME', 'SONY')
    ) WHERE product_id = 2;

select product_id, json_extract(properties, '$.weight') as product_weight from products where product_id = 1;

select product_id, properties -> '$.weight' from products where product_id = 1;