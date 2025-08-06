
# Project Title

A brief description of what this project does and who it's for

# 📚 PahanaEdu Billing System

**PahanaEdu** is a leading **bookshop in Colombo City**, serving hundreds of customers each month. This web-based billing system was developed to **digitize and streamline customer account and billing management**, replacing the current manual process.

The system is designed for use by **shop staff and administrators** to manage:
- Customer registrations
- Item (book/product) inventory
- Billing and payment calculations
- Account records

It ensures secure login, efficient record-keeping, and automated bill generation based on the units (e.g., books or items) consumed.

> 🎯 This system is ideal for bookshops or similar retail stores that need a **reliable billing and customer management solution**.



## 👤 Authors

**Pasan Sandeepa**  
- Email: Pasansandeepa72726@gmail.com  
- GitHub: [github.com/CHEY9](https://github.com/your-username)  
- LinkedIn: [linkedin.com/in/pasan-sandeepa](https://linkedin.com/in/pasan-sandeepa)
## 🚀 Deployment

To deploy the PahanaEdu Billing System, follow these steps:

1. **Set up the database**  
   - Open SQL Server Management Studio (SSMS).  
   - Run the `pahanaedu.sql` script located in the `database/` folder to create tables and seed initial data.

2. **Configure the project**  
   - Update the database connection settings in your configuration file (e.g., `db.properties` or similar) with your SQL Server credentials.

3. **Build the project**  
   - Import the project into your IDE (IntelliJ IDEA or Eclipse) as a Maven project.  
   - Build the project to generate the `.war` file.

4. **Deploy to Apache Tomcat**  
   - Copy the generated `.war` file into the Tomcat `webapps` directory.  
   - Start or restart the Tomcat server.  
   - Access the application via `http://localhost:8081/PahanaEdu` .

5. **Login and use the system**  
   - Use the default admin credentials or register a new user to start managing billing.

---




## 📚 Documentation

This project includes documentation to assist both users and developers:

- **User Guide**  
  Provides step-by-step instructions on how to use the system features such as login, customer management, billing, and reports.

- **Developer Guide**  
  Contains information on setting up the development environment, project structure, and guidelines for contributing or extending the system.


## ❓ FAQ

#### Q1: How do I register a new customer?

Log in as Admin or Staff and go to the **Customer Management** section. Click **Add New Customer**, fill out the required fields (account number, name, address, telephone, etc.), and save the details.

#### Q2: How do I edit customer information?

Navigate to **Customer Management**, select the customer you want to update, click **Edit**, make the changes, and save.

#### Q3: How do I manage item information?

In the **Item Management** section, you can add new items, update existing item details (name, category, price, stock), or delete items that are no longer sold.

#### Q4: How is the bill amount calculated?

The bill is calculated based on the quantity of each item purchased multiplied by its unit price. The system automatically totals these amounts and updates the item stock after billing.

#### Q5: How can I print or save a bill?

After creating a bill, go to the **View Bills** section. Select the bill you want and click the **Print** button to print or save it as a PDF.

#### Q6: What happens if I forget my password?

Use the **Forgot Password** option on the login page. An OTP will be sent to your registered email for verification. Enter the OTP to reset your password securely.

#### Q7: How do I access reports?

Admin users can access reports from the **Reports** section. Available reports include daily/monthly sales, most sold items, and top customers.

#### Q8: How is user authentication handled?

The system requires a username and password for login. It implements role-based access control, restricting certain features to Admins or Staff accordingly.

#### Q9: How do I update my profile or change my password?

Go to the **Profile Management** section where you can update your profile details, upload a profile picture, and change your password.

#### Q10: Is there a help section available?

Yes, the system includes a **Help Section** accessible from the main menu, which provides usage guidelines for new users.

#### Q11: How do I exit the system?

You can log out at any time using the **Logout** option in the navigation menu to safely close your session.

---

## 🚀 Features

- Secure user authentication with role-based access (Admin and Staff)  
- Add, edit, and delete customer accounts with detailed information  
- Manage item inventory: add, update, and remove items with stock tracking  
- Automatic low stock alert emails sent to Admin when item stock falls below a threshold  
- Create, view, edit, and print bills with automatic total calculation  
- Real-time stock quantity updates upon billing  
- Generate comprehensive reports: daily/monthly sales, most sold items, top customers  
- Profile management: view/edit profile, change password, upload profile picture  
- Forgot password feature with OTP verification via email  
- Audit logs to track user actions and data changes  
- Help section with usage guidelines for new users

## 📚 Lessons Learned

Building the PahanaEdu Billing System was a valuable learning experience that helped me improve both technical and project management skills.

### Key takeaways:

- **Understanding MVC architecture:** Implementing the separation of concerns between the frontend (JSP), backend (Servlets), and database strengthened my grasp of MVC design principles.
- **Database integration:** Working with SQL Server and designing efficient queries for CRUD operations and reports deepened my knowledge of relational databases.
- **Session management & security:** Implementing secure login, role-based access control, and password recovery via OTP taught me important security best practices.
- **Handling real-time data updates:** Managing stock quantities and ensuring consistency during billing was challenging but improved my understanding of transactional data handling.
- **Email integration:** Setting up automated emails for OTP verification and low stock alerts introduced me to JavaMail API and external service integration.
- **User-friendly design:** Balancing functional requirements with usability reinforced the importance of clear UI/UX design.
- **Problem-solving:** Debugging deployment issues on Apache Tomcat and configuring the environment enhanced my troubleshooting skills.

### Challenges & Overcoming Them:

- Initially, managing database connections and resource cleanup caused errors. I resolved this by implementing proper connection pooling and finally using try-with-resources.
- Designing flexible report queries to handle varying date ranges and filters required iterative testing and optimization.
- Integrating email services posed authentication and network challenges, which I overcame by configuring SMTP settings carefully and using secure app passwords.

Overall, this project helped me develop a solid full-stack Java web application and prepared me for future real-world projects.


## 🛠️ Installation

Follow these steps to install and run the PahanaEdu Billing System on your local machine:

### Requirements
- Java 17 or above
- Apache Tomcat 10+
- SQL Server
- Maven (for dependency management)
- IDE like IntelliJ IDEA or Eclipse

### Steps

1. **Clone the Repository**

```bash
git clone https://github.com/CHEY9/PahanaEdu.git
cd PahanaEdu
Import into IDE

Open your IDE (IntelliJ or Eclipse)

Import as a Maven project

Set Up the Database

Open SQL Server Management Studio (SSMS)

Run the pahanaedu.sql script (found in /database) to create tables and seed data

Configure Database Connection

Open the db.properties file or relevant configuration file

Set your DB credentials (URL, username, password)

Build and Deploy

Build the project to generate a .war file

Copy the .war file into Tomcat's /webapps/ directory

Start the Tomcat server

Access the Application

Open your browser and go to:
http://localhost:8081/PahanaEdu

