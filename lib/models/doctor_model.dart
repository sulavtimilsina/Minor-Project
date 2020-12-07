class DoctorInfo {
  final String name,
      image,
      speciality,
      about,
      address,
      workingHours,
      experience,
      nmcNumber,
      certifications;
  final List<String> education;

  DoctorInfo({
    this.name,
    this.image,
    this.speciality,
    this.about,
    this.address,
    this.workingHours,
    this.experience,
    this.certifications,
    this.education,
    this.nmcNumber,
  });
}