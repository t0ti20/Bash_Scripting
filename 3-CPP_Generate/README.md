## Description

This script is a simple Bash tool designed to generate C++ header and program files with a basic template. It prompts the user to enter information such as author name, email, file name, class name, and namespace. The generated files include a header file (.hpp) and a program file (.cpp) with predefined structures and comments.

## Usage

1. Make the script executable: `chmod +x cppgenerate.sh`
2. Run the script: `./cppgenerate.sh`
3. Follow the prompts to enter the required information.
4. Optionally, add external options such as attributes (public, private, protected).
5. Review the entered information and confirm or edit as needed.

## Script Organization

- **Script Variables**: Initial variables such as author name and email.
- **Set Default Values**: Function to set default values for file name, class name, namespace, and description.
- **Generate Header**: Function to generate the C++ header file with a predefined template.
- **Get Data**: Function to handle external options by adding attributes based on the user's input.
- **Generate Program**: Function to generate the C++ program file with a predefined template.
- **Add Attributes**: Function to interactively add attributes (public, private, protected) to the class.
- **External Options**: Function to handle user input for external options (e.g., adding attributes).
- **Input Needed Data**: Main loop for user interaction, allowing the user to confirm or edit the entered information.

## Examples

Here are a few examples of using the script:

![image](https://github.com/t0ti20/Bash_Scripting/assets/61616031/e308d1b1-82d5-4aa9-a937-4f017ca4225e)

- Basic Usage:
```bash
./cppgenerate.sh
```
## Author

- Khaled El-Sayed
- Email: @t0ti20

## License

This script is provided under the MIT License.

---
