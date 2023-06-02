# carroll_fulmer_pay

Carroll Fulmer Tiered Pay Calculator

## Summary

This is a calculator that I created to figure out what my pay would look like based on the miles I
drive.

I originally created a version an iOS only version in Swift with SwiftUI but I lost it the project
code. I decided to recreate the app from scratch in Flutter 3.7.x and I am uploading it to GIT so I
don't loose it again.

## Tax Information

The federal taxes are calculated from the 2023 versions of...

- IRS Publication 15-T: Federal Income Tax Withholding Methods.
- IRS Form W4: Employee’s Withholding Certificate.

The rest of the taxes I calculated from...
https://onpay.com/payroll/process/how-to-calculate-payroll-taxes

I only implemented single filing status. If this app was for wide release I would have added a tax
settings page but it seems like overkill for a personal tool. This is just for me.

## To Do

- Nothing.

## Commits

- 2023.06.02 06:00p - Added pay per mile to the results page.

- 2023.03.05 01:15p - Cleaning up some code.

- 2023.03.04 05:45p - Added Data Persistence
    - Added data persistence for the text fields using shared_preferences.
    - https://pub.dev/packages/shared_preferences

- 2023.03.04 12:45p - Added Tax Calculations
    - Added tax calculations to the app.

- 2023.03.04 12:45a - Added Pay Calculations
    - Added pay calculations to the app.

- 2023.03.04 11:00a - Initial Commit
    - Created the initial layout of the app.
    - Created custom evaluated text edit widgets.
    - Added currency formatting using intl
    - https://pub.dev/packages/intl
