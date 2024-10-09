import 'package:jop_finder_app/features/job_search/models/filters.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
// final List<Job> allJobs = [
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$120,000 - \$130,000',
//     companyName: 'Google',
//     location: 'San Francisco, CA',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'UI/UX Designer',
//     salary: '\$80,000 - \$90,000',
//     companyName: 'Meta',
//     location: 'Seattle, WA',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Entry Level',
//     jobType: 'Full-time',
//     role: 'UI/UX Designer',
//   ),
//   Job(
//     jobTitle: 'Project Manager',
//     salary: '\$130,000 - \$140,000',
//     companyName: 'Amazon',
//     location: 'New York, NY',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Associate',
//     jobType: 'Full-time',
//     role: 'Project Manager',
//   ),
//   Job(
//     jobTitle: 'Data Analyst',
//     salary: '\$90,000 - \$100,000',
//     companyName: 'Apple',
//     location: 'Austin, TX',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Entry Level',
//     jobType: 'Full-time',
//     role: 'Data Analyst',
//   ),
//   Job(
//     jobTitle: 'Backend Developer',
//     salary: '\$140,000 - \$150,000',
//     companyName: 'Microsoft',
//     location: 'San Jose, CA',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Backend Developer',
//   ),
//   Job(
//     jobTitle: 'Frontend Developer',
//     salary: '\$110,000 - \$120,000',
//     companyName: 'Google',
//     location: 'San Diego, CA',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Associate',
//     jobType: 'Contract',
//     role: 'Frontend Developer',
//   ),
//   Job(
//     jobTitle: 'UI/UX Designer',
//     salary: '\$70,000 - \$80,000',
//     companyName: 'Meta',
//     location: 'Chicago, IL',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Internship',
//     jobType: 'Internship',
//     role: 'UI/UX Designer',
//   ),
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$150,000 - \$160,000',
//     companyName: 'Amazon',
//     location: 'Dallas, TX',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'Data Analyst',
//     salary: '\$100,000 - \$110,000',
//     companyName: 'Apple',
//     location: 'Fort Worth, TX',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Associate',
//     jobType: 'Full-time',
//     role: 'Data Analyst',
//   ),
//   Job(
//     jobTitle: 'Frontend Developer',
//     salary: '\$110,000 - \$120,000',
//     companyName: 'Microsoft',
//     location: 'Houston, TX',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Entry Level',
//     jobType: 'Contract',
//     role: 'Frontend Developer',
//   ),
//   Job(
//     jobTitle: 'Backend Developer',
//     salary: '\$140,000 - \$150,000',
//     companyName: 'Google',
//     location: 'Philadelphia, PA',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Backend Developer',
//   ),
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$170,000 - \$180,000',
//     companyName: 'Meta',
//     location: 'Seattle, WA',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Director',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'Project Manager',
//     salary: '\$120,000 - \$130,000',
//     companyName: 'Amazon',
//     location: 'Los Angeles, CA',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Project Manager',
//   ),
//   Job(
//     jobTitle: 'UI/UX Designer',
//     salary: '\$80,000 - \$90,000',
//     companyName: 'Apple',
//     location: 'New York, NY',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Associate',
//     jobType: 'Full-time',
//     role: 'UI/UX Designer',
//   ),
//   Job(
//     jobTitle: 'Frontend Developer',
//     salary: '\$110,000 - \$120,000',
//     companyName: 'Microsoft',
//     location: 'San Jose, CA',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Contract',
//     role: 'Frontend Developer',
//   ),
//   Job(
//     jobTitle: 'Data Analyst',
//     salary: '\$90,000 - \$100,000',
//     companyName: 'Google',
//     location: 'San Antonio, TX',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Entry Level',
//     jobType: 'Full-time',
//     role: 'Data Analyst',
//   ),
//   Job(
//     jobTitle: 'Backend Developer',
//     salary: '\$140,000 - \$150,000',
//     companyName: 'Meta',
//     location: 'Denver, CO',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Backend Developer',
//   ),
//   Job(
//     jobTitle: 'Project Manager',
//     salary: '\$130,000 - \$140,000',
//     companyName: 'Amazon',
//     location: 'Phoenix, AZ',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Project Manager',
//   ),
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$150,000 - \$160,000',
//     companyName: 'Apple',
//     location: 'Houston, TX',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'UI/UX Designer',
//     salary: '\$90,000 - \$100,000',
//     companyName: 'Microsoft',
//     location: 'San Francisco, CA',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Associate',
//     jobType: 'Full-time',
//     role: 'UI/UX Designer',
//   ),
//   Job(
//     jobTitle: 'Data Analyst',
//     salary: '\$80,000 - \$90,000',
//     companyName: 'Google',
//     location: 'Washington, DC',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Entry Level',
//     jobType: 'Full-time',
//     role: 'Data Analyst',
//   ),
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$170,000 - \$180,000',
//     companyName: 'Meta',
//     location: 'Jacksonville, FL',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Director',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'Backend Developer',
//     salary: '\$140,000 - \$150,000',
//     companyName: 'Amazon',
//     location: 'Columbus, OH',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Backend Developer',
//   ),
//   Job(
//     jobTitle: 'Frontend Developer',
//     salary: '\$130,000 - \$140,000',
//     companyName: 'Apple',
//     location: 'Austin, TX',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Associate',
//     jobType: 'Contract',
//     role: 'Frontend Developer',
//   ),
//   Job(
//     jobTitle: 'UI/UX Designer',
//     salary: '\$100,000 - \$110,000',
//     companyName: 'Microsoft',
//     location: 'San Antonio, TX',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'UI/UX Designer',
//   ),
//   Job(
//     jobTitle: 'Project Manager',
//     salary: '\$120,000 - \$130,000',
//     companyName: 'Google',
//     location: 'Indianapolis, IN',
//     imageUrl: 'https://logo.clearbit.com/google.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Project Manager',
//   ),
//   Job(
//     jobTitle: 'Backend Developer',
//     salary: '\$160,000 - \$170,000',
//     companyName: 'Meta',
//     location: 'Charlotte, NC',
//     imageUrl: 'https://logo.clearbit.com/meta.com',
//     experienceLevel: 'Executive',
//     jobType: 'Full-time',
//     role: 'Backend Developer',
//   ),
//   Job(
//     jobTitle: 'Frontend Developer',
//     salary: '\$130,000 - \$140,000',
//     companyName: 'Amazon',
//     location: 'Los Angeles, CA',
//     imageUrl: 'https://logo.clearbit.com/amazon.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Contract',
//     role: 'Frontend Developer',
//   ),
//   Job(
//     jobTitle: 'Software Engineer',
//     salary: '\$180,000 - \$190,000',
//     companyName: 'Apple',
//     location: 'Philadelphia, PA',
//     imageUrl: 'https://logo.clearbit.com/apple.com',
//     experienceLevel: 'Executive',
//     jobType: 'Full-time',
//     role: 'Software Engineer',
//   ),
//   Job(
//     jobTitle: 'Project Manager',
//     salary: '\$130,000 - \$140,000',
//     companyName: 'Microsoft',
//     location: 'San Diego, CA',
//     imageUrl: 'https://logo.clearbit.com/microsoft.com',
//     experienceLevel: 'Mid-Senior Level',
//     jobType: 'Full-time',
//     role: 'Project Manager',
//   ),
// ];

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