# **P**urchase **O**ptimizer and **R**ecipy **M**odifier <!-- omit in toc -->
## Table of contents <!-- omit in toc -->
- [Description](#description)
- [List of wanted features](#list-of-wanted-features)
  - [Recipy Manager](#recipy-manager)
  - [Purchase optimizer](#purchase-optimizer)
  - [Miscellaneous](#miscellaneous)

## Description
PORM is an application in two forms, a recipy manager that is mainly used to store recipy sizes and a purchase optimizer that will optimize and craft a shopping-list depending on price, recipy nutrients etc.

## List of wanted features
### Recipy Manager
- Print recipies using $\LaTeX$
- GUI for creating a recipy
- A markdown-language that is used to parse typed recipies
- Storage-manager for variations of the same recipy
- Quick conversions between sizes of recipies
- Extract required ingridients for a recipy or recipies
    
### Purchase optimizer
- Optimizing goals
  - Price
  - Nutrients
  - Rating (taste)
  - Cooking time
- Optimizing requirements
  - Max/Min price
  - Max/Min nutrients
  - Least/Max number of recipies from category
  - Number of unique recipies
- Optimization tactics
  - Combining recipies with similar ingredients in order to buy cheaper products
  - Make use of existing home-inventory
  - Reduce amount of left-over waste (money spent on unused food)
- Support multiple, weighted goals
- Having both *requirements* and *goals* for optimization
- A GUI for crafting a purchase plan
  - Input goals and requirements
  - Selecting recipy database
  - Selecting price database
- Must be able to handle an entire week's plan in a reasonable time

### Miscellaneous
- Generate a cooking scheduele from a recipy list based on ingredient expiry dates, available time, number of portions