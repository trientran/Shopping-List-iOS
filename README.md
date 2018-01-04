# Shopping-List-iOS 

This iOS app is a major assignment for the iOS Development course from TAFE SA (Australia)

## Background

The purpose of this assignment is to create a shopping list application using iPhone SDK, similar to many you have seen on the App Store. Your application will help users to manage their shopping with some added functionality.

## Core Functionalities
You application should have to have following core functionalities. See the Merit section for the additional functionalities.

Add Items to the shopping List – User will be able to add new shopping items to the list
Display Items – User will be able to view the shopping list
Remove Items – User will be able to remove items from the list
Display a Summary – User will be able to display a summary, which includes approximate cost in dollars.
Save Favourite Store Locations – User will be able to save the favourite store locations to a database and display the locations in a table view or picker view

## Developing the Shopping List

You are required to develop a shopping cart web application using iPhone SDK and SQLite database. The application will allow users to store and manage their shopping list. 

Your application must include the following specifications: 

•	Database – Shopping list will be stored on a database (DBShoppingList), which consists of a database table, shoppinglist (You may add more tables, if required).

key	integer	Primary Key
item	text	Not Null
price	double	Not Null
group	text	Not Null
quantity	integer	Not Null

Note: To start with shopping list should be empty (no data). You are also encouraged to use Tab Bar Controller interface to manage different views of the application.
•	Add Items to the shopping List - This allows a user to add new items to the shopping list. Use the user interface below as a guide.
 

•	Display Items – This allows a user to view the shopping list in a tabular view. Item name price and quantity are the required fields (You may add other fields and images if required). Use the user interface below as a guide.
 
•	Remove Items – This allows a user to remove a selected item from the list. When you remove an item, item must be removed from the database. Use the user interface below as a guide.
 
•	Display a Summary – This allows a user to see the estimated total amount for the shopping trip. Use the user interface below as a guide.
 			
•	   Add another tab (Favourites) to your application to add a favourite store location (Address) to a list. User can add the location via a TextFields to a PickerView or TableView. You are required to add a separate class and a database table to store this information (Address details). Use the user interface below as a guide.

		 

## Merits

•	Sent an Email – This allows a user to send the shopping list to a selected email. You can either add a separate tab to the app or modify the order summary (total) tab to incorporate this functionality.
1 Merit
•	Delete Update Favourite Store – This functionality allows a user to delete or update favourite store details. You can modify the favourite store tab (Address) to incorporate this functionality.
1 Merit
