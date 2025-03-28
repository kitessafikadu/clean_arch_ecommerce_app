# eCommerce Clean Architecture

This project is an eCommerce mobile application built using Clean Architecture principles and Test-Driven Development (TDD). The application allows users to manage products (CRUD operations) in an eCommerce platform. It follows the principles of Clean Architecture to ensure maintainable, scalable, and testable code.

## Overview

This mobile application allows users to:

- Add new products to the store.
- Update product details.
- Delete products from the store.
- View product details and all products.

The project demonstrates the use of Clean Architecture principles to separate concerns into distinct layers such as domain, data, and presentation layers. It also utilizes TDD for ensuring the code is well-tested.

## Project Structure

The project follows Clean Architecture, which consists of three primary layers:

1. **Domain Layer**:

   - Entities: Represent the core business objects.
   - Use Cases: Define business logic for CRUD operations (Create, Read, Update, Delete).
   - Repositories: Define the contract for interacting with data sources.

2. **Data Layer**:

   - Models: Represents data structures, often for communication between layers.
   - Repositories Implementation: Implements the logic for interacting with data sources.
   - Data Sources: Handles fetching and saving data (e.g., APIs, databases).

3. **Presentation Layer**:
   - Providers: Manages application state and interacts with use cases.
   - UI Components: Flutter widgets for user interaction.

## Technologies

- **Dart**: Programming language used for Flutter development.
- **Flutter**: Framework for building natively compiled applications for mobile from a single codebase.
- **Clean Architecture**: A design pattern used to separate the code into layers, ensuring maintainability and scalability.
- **Test-Driven Development (TDD)**: Approach where tests are written before writing the actual code to ensure functionality and reduce bugs.
- **Mockito**: Library for mocking objects in tests.

## Setup and Installation

To get started with this project locally, follow these steps:

### Prerequisites

- Install [Flutter](https://flutter.dev/docs/get-started/install).
- Ensure Dart SDK is set up (it comes with Flutter).
- Set up an editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Clone the Repository

```bash
git clone https://github.com/kitessafikadu/clean_arch_ecommerce_app.git
cd ecommerce_clean_arch
```

### Run the Application

```bash
flutter run
```
