pragma solidity ^0.5.11;
contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // accounts or voters list
    mapping(address => bool) public voters;
    // list of candidate IDs
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // same address voting again not permissible
        require(!voters[msg.sender], 'You Have Already Voted');

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount,  'Error 2');

        // vote flag of voter to true. can't vote again
        voters[msg.sender] = true;

        // voted candidate gets one more vote
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}