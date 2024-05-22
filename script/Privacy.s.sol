// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol"; 

contract PrivacyScript is Script {

    Privacy private privacyContract;

    function run() external {
        console.log("Solving Privacy Contract...");

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy a new contract
        privacyContract = new Privacy([bytes32(0), bytes32(0), bytes32(0)]);
        vm.deal(address(privacyContract), 1 wei);
        vm.stopBroadcast();

        console.log("Privacy Contract Address: ", address(privacyContract));

        // Check the initial lock state
        console.log("State of lock: ", privacyContract.locked());

        // Loop through a limited number of keys (brute force)
        for (uint256 i = 0; i < 1000; i++) { 
            // Start a new broadcast
            vm.startBroadcast(deployerPrivateKey);

            // Call the unlock function with the current key
            privacyContract.unlock(bytes16(bytes32(i)));

            vm.stopBroadcast();

            if (!privacyContract.locked()) {
                console.log("Lock successfully opened with key");
                break;
            }
        }
    }
}
