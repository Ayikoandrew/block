// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {RegisterAccess} from "../src/RegisterAccess.sol";

contract DeployRegisterAccess is Script {
    function run() public returns (RegisterAccess) {
        vm.startBroadcast();
        RegisterAccess registerAccess = new RegisterAccess();
        vm.stopBroadcast();

        return registerAccess;
    }
}
