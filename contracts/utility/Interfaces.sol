// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Structures.sol";

interface ClientInter {
    function isClient() external view returns (bool res);

    function addClient(string memory uid, string memory secret) external;

    function getClient(
        address client_id
    )
        external
        view
        returns (address id, string memory uid, string memory secret);

    function getClientId(string memory uid) external view returns (address id);

    function addRes(
        address client_id,
        string memory user_uid,
        string memory token,
        string memory scope
    ) external;

    function getRes(
        string memory user_uid
    ) external view returns (Resource memory res);

    function toggleStatus(address client_id, string memory user_uid) external;

    function changeScope(
        address client_id,
        string memory user_uid,
        string memory scope
    ) external;
}

interface OAuth3Inter {
    function isUser() external view returns (bool res);
}
