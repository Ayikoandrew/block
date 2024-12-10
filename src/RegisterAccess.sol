// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

error notOwner();
error notAllowlisted();

contract RegisterAccess {
    string[] private info;
    address public owner;
    mapping(address => bool) public allowlist;

    constructor() {
        owner = msg.sender;
        allowlist[msg.sender] = true;
    }

    event InfoChange(string oldInfo, string newInfo);

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert notOwner();
        }
        _;
    }

    modifier onlyAllowedList() {
        if (!allowlist[msg.sender]) {
            revert notAllowlisted();
        }
        _;
    }

    function getInfo(uint256 index) public view returns (string memory) {
        return info[index];
    }

    function setInfo(uint256 index, string memory newInfo) public onlyOwner {
        string memory oldInfo = info[index];
        emit InfoChange(oldInfo, newInfo);
        info[index] = newInfo;
    }

    function addInfo(
        string memory _info
    ) public onlyAllowedList returns (uint256) {
        info.push(_info);
        return info.length - 1;
    }

    function listInfo() public view returns (string[] memory) {
        return info;
    }

    function addMember(address _member) public onlyOwner {
        allowlist[_member] = true;
    }

    function removeMemeber(address _member) public onlyOwner {
        allowlist[_member] = false;
    }
}
