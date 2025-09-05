// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tswana (`tn`).
class AppLocalizationsTn extends AppLocalizations {
  AppLocalizationsTn([String locale = 'tn']) : super(locale);

  @override
  String get loginTitle => 'O boa gape!';

  @override
  String get loginSubtitle => 'Tsena go tsweletsa tiro ya gago.';

  @override
  String get emailLabel => 'Aterese ya Email';

  @override
  String get passwordLabel => 'Lephoko la sephiri';

  @override
  String get forgotPassword => 'O lebetse lephoko la sephiri?';

  @override
  String get signIn => 'Tsena';

  @override
  String get noAccount => 'Ga o na akhaonto?';

  @override
  String get createAccount => 'Bula akhaonto';

  @override
  String get registerTitle => 'Tsenela Hustle Link Gompieno!';

  @override
  String get registerSubtitle =>
      'Bula akhaonto ya gago ya mahala mme o simolole go golagana le ditiro tse di makatsang gompieno!.';

  @override
  String get confirmPasswordLabel => 'Netefatsa Lephoko la Sephiri';

  @override
  String get registerButton => 'Ikwadise';

  @override
  String get resetPassword => 'Seta Lephoko la Sephiri Sesha';

  @override
  String get resetPasswordSubtitle =>
      'Tsenya email ya gago go amogela kgolagano ya go seta lephoko la sephiri sesha.';

  @override
  String get resetPasswordButton => 'Romela Kgolagano ya go Seta Sesha';

  @override
  String get alreadyHaveAccount => 'O setse o na le akhaonto?';

  @override
  String get signOut => 'Tswa';

  @override
  String get signOutConfirmation => 'A o batla go tswa?';

  @override
  String get signOutSuccess => 'O tswile ka katlego.';

  @override
  String get signOutError => 'Go tswa go paletswe. Lekola gape.';

  @override
  String get registrationSuccess => 'Ikwadiso e atlegile! Tsena go tswelela.';

  @override
  String get registrationError => 'Ikwadiso e paletswe. Lekola gape.';

  @override
  String get loginError =>
      'Go tsena go paletswe. Lekola tshedimosetso ya gago mme o leke gape.';

  @override
  String get emailRequired => 'Email e a tlhokega.';

  @override
  String get passwordRequired => 'Lephoko la sephiri le a tlhokega.';

  @override
  String get confirmPasswordRequired =>
      'Tsweetswee netefatsa lephoko la gago la sephiri.';

  @override
  String get passwordsDoNotMatch => 'Maphoko a sephiri ga a tshwane.';

  @override
  String get invalidEmail =>
      'Tsweetswee tsenya aterese ya email e e nepagetseng.';

  @override
  String get weakPassword =>
      'Lephoko la sephiri le tshwanetse go nna le ditlhaka di le 6 go ya godimo.';

  @override
  String get userNotFound => 'Ga go na modirisi yo o fitlhetsweng ka email e.';

  @override
  String get createNewAccount => 'Bula akhaonto e ntšha';

  @override
  String get loadingMessage => 'E tsena, tsweetswee emela...';

  @override
  String get registrationLoadingMessage => 'E a ikwadisa, tsweetswee emela...';

  @override
  String get passwordResetTitle => 'Go Seta Lephoko la Sephiri Sesha';

  @override
  String get passwordResetSubTitle =>
      'Tsenya aterese ya email ya gago fa tlase go amogela kgolagano ya go seta lephoko la sephiri sesha.';

  @override
  String get emailHint => 'Tsenya email ya gago';

  @override
  String get sendButtonText => 'Romela Kgolagano ya go Seta Sesha';

  @override
  String get backToLogin => 'Boela kwa go Tsena';

  @override
  String get checkYourEmail => 'Lekola email ya gago';

  @override
  String passwordResetLinkSent(Object email) {
    return 'Re rometse kgolagano ya go seta lephoko la sephiri sesha kwa go:\n$email';
  }

  @override
  String get resendLink => 'Romela gape kgolagano';

  @override
  String resendAvailableIn(Object seconds) {
    return 'Go romela gape go tla kgonagala mo metsotswaneng e $seconds';
  }

  @override
  String get didNotGetEmail =>
      'Ga o a amogela email? Lekola foromo ya gago ya spam kgotsa leka gape.';

  @override
  String get completeYourProfile => 'Tlatsa Porofaele ya Gago';

  @override
  String get whatsYourName => 'Leina la gago ke mang?';

  @override
  String get fullName => 'Leina le le feletseng';

  @override
  String get enterYourFullName => 'Tsenya leina la gago le le feletseng';

  @override
  String get whatBringsYouToHustleLink => 'O tletse eng mo Hustle Link?';

  @override
  String get chooseYourRole => 'Tlhopha karolo ya gago go simolola';

  @override
  String get imAHustler => 'Ke Motho wa Tiro';

  @override
  String get lookingForFreelanceWork => 'Ke batla tiro ya nakwana le dikgwebo';

  @override
  String get imAnEmployer => 'Ke Mohiri';

  @override
  String get lookingToHireTalent =>
      'Ke batla go hira batho ba ba nang le talente';

  @override
  String get getStarted => 'Simolola';

  @override
  String get tryAgain => 'Leka gape';

  @override
  String get findJobs => 'Bata Ditiro';

  @override
  String welcomeBack(Object name) {
    return 'O boa gape, $name!';
  }

  @override
  String get addSkillsToProfile =>
      'Tsenya bokgoni mo porofaeleng ya gago go bona ditiro tse di maleba';

  @override
  String jobsMatchingYourSkills(Object skills) {
    return 'Ditiro tse di tsamaelanang le bokgoni jwa gago: $skills';
  }

  @override
  String get noJobsAvailable => 'Ga go na ditiro tse di leng teng';

  @override
  String get checkBackLater =>
      'Lekola gape moragonyana go bona ditšhono tse disha';

  @override
  String errorLoadingJobs(Object error) {
    return 'Phoso e nnile teng fa go laolwa ditiro: $error';
  }

  @override
  String get retry => 'Leka gape';

  @override
  String get profileNotFound => 'Porofaele ga e a fitlhelwa';

  @override
  String errorLoadingProfile(Object error) {
    return 'Phoso e nnile teng fa go laolwa porofaele: $error';
  }

  @override
  String moreSkills(Object count) {
    return '+$count bokgoni gape';
  }

  @override
  String applicants(Object count) {
    return '$count bakopi';
  }

  @override
  String get justNow => 'Gone jaanong';

  @override
  String ago(Object time) {
    return '$time fetileng';
  }

  @override
  String get myApplications => 'Dikopo Tsa Me';

  @override
  String get noApplicationsYet => 'Ga go na Dikopo Tšhono';

  @override
  String get startApplyingForJobs =>
      'Simolola go dira dikopo tsa ditiro go di bona fano';

  @override
  String get errorLoadingApplications =>
      'Phoso e nnile teng fa go laolwa dikopo';

  @override
  String get jobTitle => 'Sehlogo sa Tiro';

  @override
  String appliedAs(Object name) {
    return 'O kopile jaaka $name';
  }

  @override
  String get coverLetter => 'Lokwalo lwa Kopo:';

  @override
  String applied(Object timeAgo) {
    return 'E kopilwe $timeAgo fetileng';
  }

  @override
  String get viewJob => 'Leba Tiro';

  @override
  String get pending => 'E santse e sekasekwa';

  @override
  String get reviewed => 'E sekasekilwe';

  @override
  String get accepted => 'E amogetswe';

  @override
  String get rejected => 'E ganetswe';

  @override
  String get profile => 'Porofaele';

  @override
  String get editProfile => 'Fetola Porofaele';

  @override
  String get logout => 'Tswa';

  @override
  String get contactInformation => 'Tshedimosetso ya Kgolagano';

  @override
  String get phone => 'Mogala';

  @override
  String get location => 'Lefelo';

  @override
  String get addPhoneNumberAndLocation => 'Tsenya nomoro ya mogala le lefelo';

  @override
  String get addPhoneNumber => 'Tsenya nomoro ya mogala';

  @override
  String get addLocation => 'Tsenya lefelo';

  @override
  String get skills => 'Bokgoni';

  @override
  String get addYourSkills =>
      'Tsenya bokgoni jwa gago go bona ditiro tse di maleba';

  @override
  String get statistics => 'Dipalopalo';

  @override
  String get jobsCompleted => 'Ditiro tse di Feditsweng';

  @override
  String get rating => 'Tekanyetso';

  @override
  String get experience => 'Maitemogelo';

  @override
  String get addYourWorkExperience =>
      'Tsenya maitemogelo a gago a tiro le diphitlhelelo';

  @override
  String get account => 'Akhaonto';

  @override
  String get memberSince => 'Leloko go tloga ka';

  @override
  String get accountType => 'Mofuta wa Akhaonto';

  @override
  String get hustler => 'Motho wa Tiro';

  @override
  String get supportAndActions => 'Kemonokeng & Ditiro';

  @override
  String get language => 'Puo';

  @override
  String get english => 'Sekgoa';

  @override
  String get setswana => 'Setswana';

  @override
  String get contactSupport => 'Ikgolaganye le Kemonokeng';

  @override
  String get getHelpAndSendFeedback => 'Bona thuso mme o romele maikutlo';

  @override
  String get addBio => 'Tsenya bio';

  @override
  String get profileCompletion => 'Go Tlatsa Porofaele';

  @override
  String get yourProfileIsComplete => 'Porofaele ya gago e feletse! 🎉';

  @override
  String get almostThere => 'O setse o le gaufi! Tlatsa dintlha di sekae fela.';

  @override
  String get goodProgress =>
      'Tswelelopele e ntle! Tsenya tshedimosetso e nngwe go iponagatsa.';

  @override
  String get completeYourProfileToAttractMoreOpportunities =>
      'Tlatsa porofaele ya gago go ngoka ditšhono tse dintsi.';

  @override
  String get completeProfile => 'Tlatsa Porofaele';

  @override
  String get save => 'Boloka';

  @override
  String failedToPickImage(Object error) {
    return 'Go tsaya senepe go paletswe: $error';
  }

  @override
  String failedToPickFiles(Object error) {
    return 'Go tsaya difaele go paletswe: $error';
  }

  @override
  String get profileUpdatedSuccessfully => 'Porofaele e fetotswe ka katlego!';

  @override
  String failedToUpdateProfile(Object error) {
    return 'Go fetola porofaele go paletswe: $error';
  }

  @override
  String get changePhoto => 'Fetola Senepe';

  @override
  String get addPhoto => 'Tsenya Senepe';

  @override
  String get basicInformation => 'Tshedimosetso ya Motheo';

  @override
  String get nameIsRequired => 'Leina le a tlhokega';

  @override
  String get bio => 'Bio';

  @override
  String get tellOthersAboutYourself => 'Bolelela ba bangwe ka wena...';

  @override
  String get phoneNumber => 'Nomoro ya Mogala';

  @override
  String get cityState => 'Toropo, Naga';

  @override
  String get professionalInformation => 'Tshedimosetso ya Tiro';

  @override
  String get skillsHint =>
      'Thabololo ya Wepe, Di-app tsa Selula, Tlhamo, jalo le jalo.';

  @override
  String get pleaseAddAtLeastOneSkill =>
      'Tsweetswee tsenya bokgoni bo le bongwe';

  @override
  String get separateSkillsWithCommas => 'Kgaoganya bokgoni ka khoma';

  @override
  String get experienceHint =>
      'Tlhalosa maitemogelo a gago a tiro, diporojeke, kgotsa diphitlhelelo...';

  @override
  String get certifications => 'Ditifikeiti';

  @override
  String get uploadCertificates =>
      'Tsenya ditifikeiti tsa gago, didipoloma, kgotsa ditokomane tse dingwe tsa dithuto (PDF, DOC, DOCX)';

  @override
  String get uploaded => 'E tsenitswe';

  @override
  String get readyToUpload => 'E siametse go tsenngwa';

  @override
  String get addCertifications => 'Tsenya Ditifikeiti';

  @override
  String get jobDetails => 'Dintlha tsa Tiro';

  @override
  String get jobNotFound => 'Tiro ga e a fitlhelwa';

  @override
  String get applicationSubmittedSuccessfully => 'Kopo e rometswe ka katlego!';

  @override
  String get aboutThisJob => 'Ka ga tiro e';

  @override
  String get requiredSkills => 'Bokgoni jo bo tlhokegang';

  @override
  String get details => 'Dintlha';

  @override
  String get posted => 'E Poseditswe';

  @override
  String get deadline => 'Letlha la bofelo';

  @override
  String get applyForThisJob => 'Kopa tiro e';

  @override
  String get writeACoverLetter => 'Kwala lokwalo lwa kopo (go saatege)';

  @override
  String get alreadyApplied => 'O setse o kopile';

  @override
  String get applyNow => 'Kopa Jaanong';

  @override
  String get myJobs => 'Ditiro Tsa Me';

  @override
  String welcome(Object name) {
    return 'Amogelesega, $name!';
  }

  @override
  String get postedJobs => 'Ditiro tse di Poseditsweng';

  @override
  String get noJobsPostedYet => 'Ga go na ditiro tse di poseditsweng';

  @override
  String get createYourFirstJobPosting =>
      'Bula tiro ya gago ya ntlha go batla batho ba ba nang le talente';

  @override
  String get postAJob => 'Bula Tiro';

  @override
  String get active => 'E teng';

  @override
  String get closed => 'E tswetswe';

  @override
  String get draft => 'Lokwalo lwa ntlha';

  @override
  String get postNewJob => 'Bula Tiro e Ntšha';

  @override
  String get postYourFirstJob =>
      'Bula tiro ya gago ya ntlha go batla batho ba ba nang le talente';

  @override
  String get viewApplications => 'Leba Dikopo';

  @override
  String get editJob => 'Fetola Tiro';

  @override
  String get closeJob => 'Tswala Tiro';

  @override
  String get reopenJob => 'Bula Tiro Gape';

  @override
  String get deleteJob => 'Phimola Tiro';

  @override
  String areYouSureYouWantToDelete(Object jobTitle) {
    return 'A o batla go phimola \"$jobTitle\"? Tiro e ga e kake ya busetswa.';
  }

  @override
  String get cancel => 'Tlogela';

  @override
  String get delete => 'Phimola';

  @override
  String get jobDeletedSuccessfully => 'Tiro e phimotswe ka katlego';

  @override
  String errorDeletingJob(Object error) {
    return 'Phoso e nnile teng fa go phimolwa tiro: $error';
  }

  @override
  String get jobApplications => 'Dikopo tsa Tiro';

  @override
  String get createPostingTitle => 'Bula tiro e ntšha';

  @override
  String get updatePostingTitle => 'Fetola tiro ya gago';

  @override
  String get createPostingSubtitle =>
      'Tlatsa dintlha go hohela batho ba ba nang le talente';

  @override
  String get updatePostingSubtitle =>
      'Fetola dintlha tse o batlang go di fetola';

  @override
  String get jobDescription => 'Tlhaloso ya Tiro';

  @override
  String get compensation => 'Tuelo (\$A)';

  @override
  String get jobTitleHint => 'e.g. Senior Flutter Developer';

  @override
  String get jobDescriptionHint => 'Re bolelele ka tiro e...';

  @override
  String get compensationHint => '5000';

  @override
  String get locationHint => 'Remote, New York, etc.';

  @override
  String get descriptionSubtitle =>
      'Tlhalosa karolo, maikarabelo, le ditlhokego';

  @override
  String get jobTitleRequired => 'Tsweetswee tsenya sehlogo sa tiro';

  @override
  String get jobDescriptionRequired => 'Tsweetswee tsenya tlhaloso ya tiro';

  @override
  String get jobDescriptionTooShort =>
      'Tlhaloso e tshwanetse go nna le ditlhaka di le 50 go ya godimo';

  @override
  String get skillsRequired => 'Tsweetswee tsenya bokgoni jo bo tlhokegang';

  @override
  String get compensationRequired => 'Tsweetswee tsenya tuelo';

  @override
  String get invalidAmount => 'Tsenya tuelo e e nepagetseng';

  @override
  String get postJobButton => 'Bula Tiro';

  @override
  String get saveChangesButton => 'Boloka Diphetogo';

  @override
  String get savedMessage => 'E bolokilwe!';

  @override
  String get website => 'Webosaete';

  @override
  String get addWebsite => 'Tsenya webosaete';

  @override
  String get aboutCompany => 'Ka ga Khamphani';

  @override
  String get addAShortDescriptionAboutYourCompany =>
      'Tsenya tlhaloso e khutshwane ka ga khamphani ya gago';

  @override
  String get employer => 'Mohiri';

  @override
  String get yourCompanyProfileIsComplete =>
      'Porofaele ya khamphani ya gago e feletse!';

  @override
  String get almostThereCompany =>
      'O setse o le gaufi! Tlatsa dintlha tse di setseng.';

  @override
  String get goodProgressCompany =>
      'Tswelelopele e ntle! Tsenya tshedimosetso e nngwe ka ga khamphani.';

  @override
  String get completeYourCompanyProfileToBuildTrust =>
      'Tlatsa porofaele ya khamphani ya gago go aga tshepo le bathapi.';

  @override
  String get personalInformation => 'Tshedimosetso ya Botho';

  @override
  String get companyName => 'Leina la Khamphani';

  @override
  String get companyNameIsRequired => 'Leina la khamphani le a tlhokega';

  @override
  String get companyDescription => 'Tlhaloso ya Khamphani';

  @override
  String get describeYourCompany =>
      'Tlhalosa khamphani ya gago, maikaelelo, le boleng...';

  @override
  String total(Object count) {
    return '$count palogotlhe';
  }

  @override
  String get subscriptions => 'Dipeeletso';

  @override
  String get chooseYourPlan => 'Tlhopha Leano la Gago';

  @override
  String get unlockFullPotential =>
      'Notlolla bokgoni jwa gago ka botlalo ka ditiriso tsa rona tsa premium.';

  @override
  String get freePlan => 'Leano la Mahala';

  @override
  String get viewFiveJobs =>
      'Leba go fitlha go 5 ya diphatlalatso tsa ditiro tsa bosheng';

  @override
  String get postThreeJobs => 'Phatlalatsa ditiro di le 3 mahala';

  @override
  String get premiumPlan => 'Leano la Premium';

  @override
  String get unlimitedJobPostings =>
      'Diphatlalatso tsa ditiro tse di sa lekanyediwang';

  @override
  String get unlimitedJobViews => 'Go leba ditiro tse di sa lekanyediwang';

  @override
  String get prioritySupport => 'Kemonokeng e e kwa pele';

  @override
  String get currentPlan => 'Leano la Gago';

  @override
  String get subscribe => 'Peeletsa';

  @override
  String get subscriptionSuccessful => 'Peeletso e atlegile!';

  @override
  String get authUserDisabled => 'Akhaonto e e thibetswe.';

  @override
  String get authWrongPassword => 'Lephoko la sephiri le phoso.';

  @override
  String get authEmailInUse => 'Email e setse e dirisiwa.';

  @override
  String get authNetworkError =>
      'Phoso ya kgolagano ya inthanete. Lekola kgolagano.';

  @override
  String get authTooManyRequests =>
      'Dikgopelo di dintsi. Leka gape morago ga sebakanyana.';

  @override
  String get authOpNotAllowed => 'Mokgwa ono wa go tsena ga o a dumelwa.';

  @override
  String get authGeneric => 'Go tsena go paletswe. Lekola gape.';

  @override
  String get authPasswordResetFailed =>
      'Go seta lephoko la sephiri go paletswe. Lekola gape.';
}
