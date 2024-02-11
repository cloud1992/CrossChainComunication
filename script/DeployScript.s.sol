// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Gateway} from "src/Gateway/Gateway.sol";

contract DeployScript is Script {
    function run(address _wormholeRelayer) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        console2.log("Deployer: ", deployer);
        vm.startBroadcast(deployerPrivateKey);
        Gateway gateway = new Gateway(_wormholeRelayer);
        // configuration
        gateway.setOnlyApproved(deployer, true);
        // set chainId to WormHoleChainId
        gateway.setChainToWHChainId(uint(80001), uint16(5));

        vm.stopBroadcast();
    }
}
