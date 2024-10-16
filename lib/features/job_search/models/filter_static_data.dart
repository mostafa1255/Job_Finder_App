import 'package:jop_finder_app/features/job_search/models/filters.dart';

final List<Filters> allFilters = [
  CompaniesFilter(
    companies: [
      'Google',
      'Meta',
      'Amazon',
      'Apple',
      'Microsoft',
    ],
  ),
  RolesFilter(
    roles: [
      'Software Engineer',
      'Project Manager',
      'UI/UX Designer',
      'Data Analyst',
      'Backend Developer',
      'Frontend Developer',
    ],
  ),
  JobTypesFilter(
    jobTypes: [
      'Full-time',
      'Part-time',
      'Contract',
      'Internship',
      'Temporary',
    ],
  ),
  LocationsFilter(
    locations: [
      'New York, NY',
      'Los Angeles, CA',
      'Chicago, IL',
      'Houston, TX',
      'Phoenix, AZ',
      'Philadelphia, PA',
      'San Antonio, TX',
      'San Diego, CA',
      'Dallas, TX',
      'San Jose, CA',
      'Austin, TX',
      'Jacksonville, FL',
      'Fort Worth, TX',
      'Columbus, OH',
      'Charlotte, NC',
      'Indianapolis, IN',
      'San Francisco, CA',
      'Seattle, WA',
      'Denver, CO',
      'Washington, DC',
    ],
  ),
  SalaryRangeFilter(
    salaryRanges: [
      '\$50,000 - \$60,000',
      '\$60,000 - \$70,000',
      '\$70,000 - \$80,000',
      '\$80,000 - \$90,000',
      '\$90,000 - \$100,000',
      '\$100,000 - \$110,000',
      '\$110,000 - \$120,000',
      '\$120,000 - \$130,000',
      '\$130,000 - \$140,000',
      '\$140,000 - \$150,000',
      '\$150,000 - \$160,000',
      '\$160,000 - \$170,000',
      '\$170,000 - \$180,000',
      '\$180,000 - \$190,000',
      '\$190,000 - \$200,000',
      '\$200,000 - \$210,000',
      '\$210,000 - \$220,000',
      '\$220,000 - \$230,000',
      '\$230,000 - \$240,000',
      '\$240,000 - \$250,000',
    ],
  ),
  ExperienceLevelFilter(
    experienceLevels: [
      'Internship',
      'Entry Level',
      'Associate',
      'Mid-Senior Level',
      'Director',
      'Executive',
    ],
  ),
];