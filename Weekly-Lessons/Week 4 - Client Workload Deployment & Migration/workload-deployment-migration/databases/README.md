# Database Migration Considerations

[Back to Week 4](../../README.md)

## Focus

The planned MGN demonstration is a server rehosting exercise, not a promise of database modernization or a separate managed-database migration.

A database hosted on a replicated server still requires application-consistency planning, supported configuration, recovery validation, and careful handling of writes during cutover.

## Discovery questions

- What engine/version, licensing, dependencies, and data volume are involved?
- What RTO/RPO and planned outage are approved?
- How will writes be quiesced, synchronized, and checked?
- Is rehosting appropriate, or should an engine-native process or database migration service be assessed?
- Who owns functional testing, backup/recovery validation, and rollback?

Do not run source and test databases against the same production integrations. No database service deployment is required for this conceptual section.
