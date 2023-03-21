// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./utility/Structures.sol";
import "./utility/Interfaces.sol";

// import "hardhat/console.sol";

contract ClientContract is ClientInter {
    address[2] addrs;
    mapping(address => Client) clients;
    mapping(string => address) clientId;
    uint256 public totalClients;

    constructor() {
        addrs[0] = msg.sender;
    }

    function setContractAddress(address contract_address) external {
        require(msg.sender == addrs[0], "Unauth Access");
        addrs[1] = contract_address;
    }

    modifier onlyOwner() {
        require(msg.sender == addrs[0], "Only Owner Allowed");
        _;
    }

    function isClient() external view returns (bool res) {
        if (msg.sender == clients[msg.sender].id) res = true;
        else res = false;
    }

    modifier ownerOrClient() {
        require(
            msg.sender == clients[msg.sender].id || msg.sender == addrs[0],
            "Niether a client nor owner"
        );
        _;
    }

    function addClient(string memory uid, string memory secret) external {
        Client storage client = clients[msg.sender];
        require(msg.sender != clients[msg.sender].id, "Account Already Exists");
        client.id = msg.sender;
        client.uid = uid;
        client.secret = secret;
        clientId[uid] = msg.sender;
        totalClients++;
    }

    function getClientId(string memory uid) external view returns (address id) {
        id = clientId[uid];
    }

    function getClient(
        address client_id
    )
        external
        view
        ownerOrClient
        returns (address id, string memory uid, string memory secret)
    {
        Client storage client = clients[client_id];
        id = client.id;
        uid = client.uid;
        secret = client.secret;
    }

    function addRes(
        address client_id,
        string memory user_uid,
        string memory token,
        string memory scope
    ) external onlyOwner {
        Resource storage res = clients[client_id].res[user_uid];
        require(
            keccak256(abi.encodePacked(res.uid)) !=
                keccak256(abi.encodePacked(user_uid)),
            "User already registered!"
        );

        res.uid = user_uid;
        res.token = token;
        res.scope = scope;
        res.is_active = true;
    }

    function getRes(
        address client_id,
        string memory user_uid
    ) external view ownerOrClient returns (Resource memory res) {
        res = clients[client_id].res[user_uid];
    }

    function toggleStatus(
        address client_id,
        string memory user_uid
    ) external onlyOwner {
        Resource storage res = clients[client_id].res[user_uid];
        if (res.is_active) res.is_active = false;
        else res.is_active = true;
    }

    function changeScope(
        address client_id,
        string memory user_uid,
        string memory scope
    ) external onlyOwner {
        clients[client_id].res[user_uid].scope = scope;
    }
}
