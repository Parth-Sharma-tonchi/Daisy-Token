//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DaisyToken is ERC20 {

    constructor(uint256 initialSupply) ERC20("DaisyToken", "Dsy"){
        _mint(msg.sender, initialSupply);
    }

}