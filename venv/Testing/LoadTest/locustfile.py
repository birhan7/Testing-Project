from locust import HttpUser, task, between, TaskSet
import random
from faker import Faker

class AutomationExerciseUser(HttpUser):
    wait_time = between(1, 5)
    host = "https://automationexercise.com"
    fake = Faker()

    def on_start(self):
        """Initialize session data"""
        self.session_data = {
            "email": f"testuser{random.randint(1000,9999)}@example.com",
            "password": "Test@12345",
            "logged_in": False
        }

    @task(3)
    def load_homepage(self):
        with self.client.get("/", name="01. Homepage", catch_response=True) as response:
            if response.status_code != 200:
                response.failure(f"Status {response.status_code}")
            elif "Automation Exercise" not in response.text:
                response.failure("Missing homepage content")

    # 🔍 2. User Registration and Login
    @task(2)
    class AuthFlow(TaskSet):
        @task
        def register_user(self):
            # 1. First verify the registration page loads
            with self.client.get("/signup", name="01. Get Signup Page", catch_response=True) as signup_page:
                if signup_page.status_code != 200:
                    signup_page.failure("Signup page unavailable")
                    return
            
            # 2. Prepare registration data with all required fields
            user_data = {
                "name": f"User{random.randint(1000,9999)}",
                "email": f"test{random.randint(1000,9999)}@example.com",
                "password": "Test@12345",
                "title": "Mr",
                "birth_date": "10",
                "birth_month": "May",
                "birth_year": "1990",
                "firstname": "Test",
                "lastname": "User",
                "company": "Test Company",
                "address1": "123 Test St",
                "address2": "Apt 101",
                "country": "United States",
                "state": "California",
                "city": "Los Angeles",
                "zipcode": "90001",
                "mobile_number": f"555{random.randint(1000000, 9999999)}"
            }
            
            # 3. Submit registration with debugging
            with self.client.post("/api/createAccount",  # Verify correct endpoint
            name="02. Register User",
            json=user_data,  # Using json= instead of data= for API
            catch_response=True
            ) as response:
            # Debug output
                print(f"Registration attempt for {user_data['email']}")
                print(f"Full response: {response.text}")
            
            try:
                # Parse JSON response
                response_data = response.json()
                # Check for successful registration
                if response.status_code == 200 and response_data.get("responseCode") == 201:
                    response.success()
                    print(f"Success: {response_data['message']}")
                else:
                    response.failure(f"Failed: {response_data.get('message', 'Unknown error')}")
                    
            except ValueError:
                response.failure("Invalid JSON response")
            except Exception as e:
                response.failure(f"Unexpected error: {str(e)}")

        @task
        def login_user(self):
            with self.client.post("/login", 
                name="03. Login", 
                data={
                    "email": self.parent.session_data["email"],
                    "password": self.parent.session_data["password"]
                },
                catch_response=True
            ) as response:
                if "Logged in" not in response.text:
                    response.failure("Login failed")
                else:
                    self.parent.session_data["logged_in"] = True

        @task
        def stop(self):
            self.interrupt()

    # 🔍 3. Product Browsing
    @task(4)
    class ProductFlow(TaskSet):
        @task
        def browse_products(self):
            self.client.get("/products", name="04. Product Listing")
            self.client.get(f"/product_details/{random.randint(1, 34)}", name="05. Product Detail")

        @task
        def apply_filters(self):
            self.client.get("/products?brand=jeans", name="06. Filter Brand")
            self.client.get("/products?category=women", name="07. Filter Category")

        @task
        def stop(self):
            self.interrupt()

    # 🛒 4. Cart Actions
    @task(3)
    def cart_actions(self):
        if not self.session_data["logged_in"]:
            return
            
        product_id = random.randint(1, 34)
        self.client.post("/add_to_cart", 
            name="08. Add to Cart", 
            data={
                "product_id": product_id,
                "quantity": random.randint(1, 3)
            }
        )
        self.client.get("/view_cart", name="09. View Cart")

    # 📦 5. Checkout Process
    @task(1)
    def complete_checkout(self):
        if not self.session_data["logged_in"]:
            return
            
        self.client.post("/add_to_cart", data={"product_id": 1, "quantity": 1})
        
        with self.client.post("/place_order", 
            name="10. Place Order", 
            data={
                "name_on_card": self.fake.name(),
                "card_number": "4111111111111111",
                "cvc": "123",
                "expiry_month": "12",
                "expiry_year": "2025"
            },
            catch_response=True
        ) as response:
            if "Order Placed" not in response.text:
                response.failure("Order failed")

  