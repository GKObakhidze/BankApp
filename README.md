# Online Banking App Simulation

![AppMockup](https://github.com/papulik/EasyBank/assets/63560236/269b3bc6-1d7c-4645-b339-b1563b759ba7)

An iOS app that simulates an online banking experience. The app includes essential banking features such as user login, registration, money transfers, card management, transaction history, and currency conversion.

## Features

- **Login Screen**: Secure login for existing users.
- **Registration Screen**: Sign up for new users.
- **Home Page**: 
  - **Send Money**: Transfer money from one user to another.
  - **Card Management**: 
    - **Horizontal Collection View**: Display all current cards.
    - **Edit Cards**: Edit existing cards.
    - **Add/Delete Cards**: Add new cards or delete existing ones.
  - **Transaction History**: View a detailed history of all transactions in a table view.
  - **Daily Currency List**: Currencies with a detailed list and search functionality.

## Installation

Follow these steps to set up the project on your local machine:

### Requirements

- Xcode with an iOS 17.5 or newer Simulator runtime
- An internet connection for Swift Package Manager, Firebase Authentication, and Firestore

1. **Clone the repository**:

    ```bash
    git clone https://github.com/GKObakhidze/BankApp.git
    ```

2. **Navigate into the project directory**:

    ```bash
    cd BankApp
    ```

3. **Open the project in Xcode**:

    ```bash
    open EasyBank.xcodeproj
    ```

4. Wait for Xcode to finish resolving the Swift Package dependencies.

5. **Build and run the project** in Xcode:

    - Select the `EasyBank` scheme and an iPhone Simulator.
    - Click the `Run` button or press `Cmd + R`.

## Usage

### Login

1. Open the app.
2. Enter your credentials and tap `Login`.

### Register

1. Tap `Register` on the login screen.
2. Fill in the registration details and tap `Sign Up`.

### Home Page

- **Send Money**: Tap on `Send Money`, fill in the recipient details and amount, then tap `Send`.
- **Edit Card**: Tap on a card in the collection view, make necessary changes, and save.
- **Add/Delete Card**: Use the `Add` button to add a new card or swipe left on a card to delete it.
- **Transaction History**: Scroll through the list of transactions to view details.
- **Currency Converter**: Tap on the `Currency Converter` to convert currencies and search for specific currencies.

## Contributing

We welcome contributions to enhance the project. To contribute:

1. Fork the repository.
2. Create a new branch for your feature: `git checkout -b feature-name`.
3. Make your changes and commit them: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature-name`.
5. Open a pull request.

## License

This project is licensed under the MIT License.

## Contact

For questions or suggestions, please contact [Zuka Papuashvili](mailto:Zurabpapuashvili@gmail.com).
