# Active Directory Enterprise Architecture

## 1. Organisation Scenario

BonganiSecure Financial Services is a simulated financial-services organisation used to demonstrate enterprise Active Directory identity management and security engineering.

The organisation has the following departments:

- Information Technology
- Finance
- Human Resources
- Risk and Compliance
- Operations

## 2. Proposed Domain Design

**Proposed domain:** `corp.bonganisecure.local`

**Domain controller:** `BS-DC01`

**Domain functional environment:** Windows Server Active Directory Domain Services (planned lab environment).

## 3. Organisational Unit Structure

```text
corp.bonganisecure.local
│
├── BonganiSecure
│   ├── Users
│   │   ├── Finance
│   │   ├── HumanResources
│   │   ├── RiskCompliance
│   │   └── Operations
│   │
│   ├── Groups
│   │
│   ├── Workstations
│   │
│   ├── Servers
│   │
│   └── PrivilegedAccounts
```

## 4. Security Design Principles

- Separate standard user accounts from privileged administrative accounts.
- Apply least privilege to directory access.
- Organise users and computers into appropriate organisational units.
- Use security groups to manage access.
- Apply Group Policy according to organisational security requirements.
- Audit privileged account activity.
- Review identity access regularly.

## 5. Implementation Status

This is a proposed logical architecture, not a live deployed Active Directory domain.

The domain controller, domain structure and organisational units will be implemented only if suitable Windows Server infrastructure becomes available.

## 6. Future Integration

The architecture can later be extended to demonstrate hybrid identity integration between Windows Server Active Directory and Microsoft Entra ID.

