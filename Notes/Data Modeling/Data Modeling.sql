# Data Modeling
# There are 4 steps
# Business Requirements - Understand the requirements, analyze the business requirement
# Build a Conceptual Model - Visual Presentation
# Build a Logical Model or Abstract Data Model - independent of Database technologies
# Build a physical Model or refine model is an implementation of logical model in database technology


# Conceptual Model
# represent the entities and their relationships.
# We can use Entity Relationship (ER) of UML (Unified Modeling Language) to visually concept the conceptual model or data modeling
# Modeling Tools
# Microsoft Visio
# Draw.io
# Lucid Chart

#Physical Model

# Normalization
# prevent data duplication
# There are 7 rules
# 1nf - 1st Normal Form - Each cell should have a single value and we can't have repeated columns
# 2nf - 2nd Normal Form - be in first normal form and Every table should describe one entity,
# and every column in that table should describe that entity
# 3nf - 3rd Normal Form - the entity is in second normal form, A column in a table should not be derived from other columns.
# ...
# 7nf - 7th Normal Form

# Mosh Pragmatic advice
# Remove duplication
# don't jump into creating table
# don't try to applied normalization rules without any information
# don't modal the universe
# don't forget the scope of the project
# don't forget about context
# EAV - Entities, Attributes, Values
# SOLUTION - Solve Today's Problems, not future problems that may never happen.
# SOLUTION - Build a model for your problem domain, not the real world.
# SOLUTION - Simplicity is the ultimate sophistication.
# Solution - DON'T be afraid  of changes, changes will be happen whether you predict or not.


# Forward Engineering Model

