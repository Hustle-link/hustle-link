import type { JobPosting } from '$lib/utils/models/firestore.models';

export const dummyJobs: JobPosting[] = [
	{
		id: 'job_001',
		employerUid: 'emp_001',
		title: 'Senior React Developer',
		description:
			'Full-time position building scalable web applications using React and modern frontend tooling.',
		skillsRequired: ['React', 'TypeScript', 'Node.js', 'REST APIs'],
		compensation: 30000,
		createdAt: new Date('2026-03-01'),
		status: 'active',
		location: 'Phakalane, Gaborone',
		employerName: 'HR Orange Botswana',
		employerCompany: 'Orange Botswana',
		applicationsCount: 14
	},
	{
		id: 'job_002',
		employerUid: 'emp_002',
		title: 'Solar Installation Technician',
		description:
			'Contract role installing and maintaining solar energy systems across residential and commercial sites.',
		skillsRequired: ['Solar PV Installation', 'Electrical Wiring', 'Health & Safety'],
		compensation: 15000,
		createdAt: new Date('2026-03-05'),
		status: 'active',
		location: 'CBD, Gaborone',
		employerName: 'HR BPC Renewable',
		employerCompany: 'BPC Renewable',
		applicationsCount: 8
	},
	{
		id: 'job_003',
		employerUid: 'emp_003',
		title: 'Graphic Designer',
		description:
			'Full-time creative role producing visual content for digital and print marketing campaigns.',
		skillsRequired: ['Adobe Illustrator', 'Figma', 'Brand Identity', 'Photoshop'],
		compensation: 18500,
		createdAt: new Date('2026-03-08'),
		status: 'active',
		location: 'Broadhurst, Gaborone',
		employerName: 'HR Mascom Wireless',
		employerCompany: 'Mascom Wireless',
		applicationsCount: 22
	},
	{
		id: 'job_004',
		employerUid: 'emp_004',
		title: 'Financial Analyst',
		description:
			'Full-time analyst role responsible for financial modelling, reporting, and investment analysis.',
		skillsRequired: ['Financial Modelling', 'Excel', 'Data Analysis', 'IFRS'],
		compensation: 24000,
		createdAt: new Date('2026-03-10'),
		status: 'active',
		location: 'Fairgrounds, Gaborone',
		employerName: 'HR BIHL Group',
		employerCompany: 'BIHL Group',
		applicationsCount: 11
	},
	{
		id: 'job_005',
		employerUid: 'emp_005',
		title: 'Sales Executive',
		description:
			'Full-time sales role driving revenue growth through client acquisition and relationship management.',
		skillsRequired: ['Sales', 'Negotiation', 'CRM', 'Communication'],
		compensation: 21500,
		createdAt: new Date('2026-03-12'),
		status: 'active',
		location: 'Francistown',
		employerName: 'HR Debswana',
		employerCompany: 'Debswana',
		applicationsCount: 19
	},
	{
		id: 'job_006',
		employerUid: 'emp_006',
		title: 'Mobile App Developer',
		description:
			'Full-time role developing and maintaining cross-platform mobile banking applications.',
		skillsRequired: ['Flutter', 'Dart', 'REST APIs', 'Firebase'],
		compensation: 33000,
		createdAt: new Date('2026-03-15'),
		status: 'active',
		location: 'Main Mall, Gaborone',
		employerName: 'HR Stanbic Bank',
		employerCompany: 'Stanbic Bank',
		applicationsCount: 31
	}
];
