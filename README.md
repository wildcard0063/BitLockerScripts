
# BitLocker Configuration Tool

This repository contains PowerShell scripts to configure and manage BitLocker encryption on standalone systems. The scripts ensure compliance with security best practices and automate the process of enabling BitLocker with TPM and recovery keys.

## Scripts Included

### 1. `EnableBitLocker.ps1`
- **Purpose**: Automates the process of enabling BitLocker on the C: drive with the following features:
  - Configures BitLocker to use TPM as a protector.
  - Adds a recovery password protector.
  - Saves the recovery key to a local file in the user's `Documents` folder.
  - Logs all actions to `BitLocker_Status_Log.txt` in the `Documents` folder.

## Usage

### Running the Script
1. **Ensure Administrative Privileges**:
   - The script must be run with administrative permissions to access BitLocker settings.

2. **Execute the Script**:
   - Open an elevated PowerShell session (Run as Administrator).
   - Navigate to the directory containing the script.
   - Run the script using:
     ```powershell
     .\EnableBitLocker.ps1
     ```

### Logs and Recovery Key
- The recovery key will be saved in the user's `Documents` folder as `BitLocker_Recovery_Key.txt`.
- All actions will be logged in the `BitLocker_Status_Log.txt` file in the same folder.

## Requirements

- **Operating System**: Windows 10 or Windows 11
- **PowerShell Version**: 5.1 or higher
- **TPM**: Trusted Platform Module (TPM) must be enabled and activated.

## Troubleshooting

### Common Errors
1. **Access Denied**:
   - Ensure the script is executed with administrative privileges.
2. **TPM Not Enabled**:
   - Verify that TPM is enabled and activated in the BIOS/UEFI settings.
3. **BitLocker Already Enabled**:
   - If BitLocker is already configured on the C: drive, the script will exit without making changes.

## Contributing

Feel free to submit issues or pull requests for bug fixes or feature enhancements.

## License

This repository is licensed under the [MIT License](LICENSE).
