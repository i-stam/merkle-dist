// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/MerkleDistributor.sol";
import "./mocks/MockERC20.sol";
import "murky/Merkle.sol";

contract MerkleDistributorTest is Test {

    MerkleDistributor public merkleDistributor;
    MockERC20 public token;
    Merkle public merkle;

    bytes32 constant merkleRoot = "";

    function setUp() public {
        token = new MockERC20();
        merkle = new Merkle();
        merkleDistributor = new MerkleDistributor(address(token), merkleRoot);
    }

    function generateData() public pure returns(bytes32[] memory) {
        bytes32[] memory data = new bytes32[](4);
        data[0] = bytes32("0x0");
        data[1] = bytes32("0x1");
        data[2] = bytes32("0x2");
        data[3] = bytes32("0x3");
        return data;
    }

    function testEmptyMerkleRoot() public {
        bytes32 expectedRoot = 0x0;
        assertEq(merkleRoot, expectedRoot);
    }

    function testMurkyRoot() public {
        bytes32[] memory data = generateData();
        bytes32 root = merkle.getRoot(data);
        bytes32[] memory proof = merkle.getProof(data, 2); // will get proof for 0x2 value
        bool verified = merkle.verifyProof(root, proof, data[2]); // true!
        assertTrue(verified);
    }
}
