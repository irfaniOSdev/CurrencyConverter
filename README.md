# Currency Converter
Simple Currency converter iOS app developed using openexchangerates API.

## Table of Contents

- [Introduction](#introduction)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Usage](#usage)

## Introduction
This project is a demo for showing currency conversions using openexchangerate API.Currency conversions happens offline and real data gets loaded after each 30 minutes.

### Features
- Enter amount in textfield to see converted amount in all currencies.
- Select your desired currency to see its rate on all other currencies.
- Configuration file available to update API Key and refresh rate.

## Tools and Technologies

List of tools and technologies used in this project.

- **Xcode**: Version 15.1
- **Programming Language**: Swift
- **UIKIT**
- **Combine**
- **MVVM**
- **Unit Testing with XCTest**

## Project Structure

Project structure is as follows:

  - CurrencyConverter
  - Code
    - Utilities
    - Constants
    - Network
    - Module
      - CurrencySelection
      - CurrencyConversion


## Usage
Instructions on how to set up and run your project. Included any configuration steps or prerequisites.

1. Clone the repository: `git clone https://github.com/irfaniOSdev/CurrencyConverter.git`
2. Open the project in Xcode with CurrencyConverter.xcworkspace
3. Open Configuration file and enter your API Key.
4. Run the project on simulator or a physical device.

![Simulator Screenshot - iPhone 15 Pro Max - 2024-02-21 at 00 07 04](https://github.com/irfaniOSdev/CurrencyConverter/assets/46619359/958bfad6-9630-447e-9cf7-e529a5dfcbbb)

![Simulator Screenshot - iPhone 15 Pro Max - 2024-02-21 at 00 07 48](https://github.com/irfaniOSdev/CurrencyConverter/assets/46619359/d18022a6-391a-4460-9174-b661a2facfc0)
