// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VerifiitAuthentication {

    struct ProductBatch {
        bytes32 manufacturerHash;
        bool exists;
    }

    mapping(bytes32 => ProductBatch) public batches;

    event BatchRegistered(bytes32 indexed batchId);
    event VerificationLogged(bytes32 indexed batchId, bytes32 scanHash);
    event ProductFlagged(bytes32 indexed batchId, bytes32 reportHash);

    function registerProductBatch(bytes32 batchId, bytes32 manufacturerHash) public {
        require(!batches[batchId].exists, "Batch already exists");
        batches[batchId] = ProductBatch(manufacturerHash, true);
        emit BatchRegistered(batchId);
    }

    function logVerificationEvent(bytes32 batchId, bytes32 scanHash) public {
        require(batches[batchId].exists, "Batch does not exist");
        emit VerificationLogged(batchId, scanHash);
    }

    function flagSuspiciousProduct(bytes32 batchId, bytes32 reportHash) public {
        require(batches[batchId].exists, "Batch does not exist");
        emit ProductFlagged(batchId, reportHash);
    }
}
