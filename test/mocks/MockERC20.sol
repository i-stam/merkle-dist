// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20("MockERC20", "MCK") {
    uint256 constant INITIAL_SUPPLY = 100_000e18;

    constructor() {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
}
