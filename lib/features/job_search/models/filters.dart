abstract class Filters{
}

class CompaniesFilter extends Filters{
  final List<String> companies;
  CompaniesFilter({required this.companies});
}
class RolesFilter extends Filters{
  final List<String> roles;
  RolesFilter({required this.roles});
}
class JobTypesFilter extends Filters{
  final List<String> jobTypes;
  JobTypesFilter({required this.jobTypes});
}
class LocationsFilter extends Filters{
  final List<String> locations;
  LocationsFilter({required this.locations});
}
class SalaryRangeFilter extends Filters{
  final List<String> salaryRanges;
  SalaryRangeFilter({required this.salaryRanges});
}
class ExperienceLevelFilter extends Filters{
  final List<String> experienceLevels;
  ExperienceLevelFilter({required this.experienceLevels});
}