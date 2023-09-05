//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployDaisyToken} from "../script/DeployDaisyToken.s.sol";
import {DaisyToken} from "../src/DaisyToken.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract DaisyTokenTest is Test {

    uint256 BOB_STARTING_AMOUNT = 1000 ether;

    DaisyToken public daisyToken;
    DeployDaisyToken public deployer;
    address public deployerAddress;

    address bob;
    address alice;

    function setUp() public {
        deployer = new DeployDaisyToken();
        daisyToken = deployer.run();

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        deployerAddress = vm.addr(deployer.deployerKey());
        vm.prank(deployerAddress);
        daisyToken.transfer(bob, BOB_STARTING_AMOUNT);
    }

    function testInitialSupply() public {
        assertEq(daisyToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000 ether;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        daisyToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500 ether;

        vm.prank(alice);
        daisyToken.transferFrom(bob, alice, transferAmount);
        assertEq(daisyToken.balanceOf(alice), transferAmount);
        assertEq(daisyToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }
}