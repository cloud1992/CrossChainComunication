// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Gateway} from "src/Gateway/Gateway.sol";
import "./DeployConfig.sol";

abstract contract DeployScript is Script, DeployConfig {
    constructor(NETWORKS network) DeployConfig(network) {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        console2.log("Deployer: ", deployer);
        vm.startBroadcast(deployerPrivateKey);
        Gateway gateway = new Gateway(_wormholeRelayer);
        gateway.setOnlyApproved(deployer, true);
        vm.stopBroadcast();
    }
}

contract DeployBSCTESNET is DeployScript {
    constructor() DeployScript(NETWORKS.BSC_TESTNET) {}
}

contract DeployMumbai is DeployScript {
    constructor() DeployScript(NETWORKS.MUMBAI) {}
}

contract DeployFUJI is DeployScript {
    constructor() DeployScript(NETWORKS.FUJI) {}
}
