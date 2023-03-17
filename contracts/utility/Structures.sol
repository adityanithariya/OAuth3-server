// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

struct DOB {
    uint8 date;
    uint8 month;
    uint16 year;
}

enum Gender {
    male,
    female,
    other,
    none
}

enum Relation {
    CO,
    DO,
    SO,
    WO,
    HO
}

enum Unit {
    cgpa,
    percentage,
    grade
}

enum Class {
    class_10,
    class_12
}

struct Relative {
    Relation relation;
    string name;
}

struct COV {
    string class_of_vehicle;
    uint40 issue_date;
}

struct PhoneNumber {
    uint8 code;
    uint40 phone_number;
}

struct Address {
    string street;
    string city;
    string state;
    uint24 pincode;
}

struct Aadhaar {
    string id; // IPFS Hash
    string uid; // AC Number
    string vid; // Virtual Id
    string name;
    Gender gender;
    PhoneNumber phone_number;
    string email;
    Address addr;
    Relative relative;
    DOB date_of_birth;
    uint40 issue_date;
    bool is_verified;
}

struct PAN {
    string id; // IPFS Hash
    string uid; // PC Number
    bool is_active;
    bool is_verified;
}

struct BirthCertif {
    string id; // IPFS Hash
    string uid; // BirthCertif Number
    DOB date_of_birth;
    Address birth_place;
    uint40 issue_date;
}

struct DeathCertif {
    string id; // IPFS Hash
    string uid; // DC Number
    uint40 death_date;
    uint40 issue_date;
}

struct MarksSheet {
    string id; // IPFS Hash
    string institute_name;
    Class class;
    uint8 marks;
    Unit unit;
    uint40 issue_date;
    uint8 [2]year;
}

struct DrivingLicense {
    string id; // IPFS Hash
    string uid; // DL Number
    uint40 reg_date; // DLR
    uint40 valid_till;
    uint40 issue_date; // DOI
    mapping (uint => COV) cov; // Class of Vehicles & DOI
}

struct User {
    address id;
    string uid;
    Aadhaar aadhaar;
    PAN pan;
    BirthCertif birth_certificate;
    DeathCertif death_certificate;
    MarksSheet [2]marks_sheet;
    DrivingLicense driving_license;
    uint40 reg_date;
    bool is_active;
}

struct Resource {
    string uid; // User Unique Identifier
    string token; // Access Token
    string scope; // Scope
    bool is_active; // Access Rights
}

struct Client {
    address id;
    string uid;
    string secret;
    mapping (string => Resource) users; // uid => Resource
}
