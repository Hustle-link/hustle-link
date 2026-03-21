/** The possible statuses of a job posting. */
export type JobStatus = 'active' | 'closed' | 'draft';

/** Represents a job posting document in Firestore. */
export interface JobPosting {
	/** The unique identifier for the job posting document in Firestore. */
	id: string;

	/** The unique identifier of the employer who created the posting. */
	employerUid: string;

	/** The title of the job. */
	title: string;

	/** A detailed description of the job, including responsibilities and requirements. */
	description: string;

	/** A list of skills required for the job. */
	skillsRequired: string[];

	/** The compensation or salary for the job. */
	compensation: number;

	/** The date and time when the job posting was created. */
	createdAt: Date;

	/** The current status of the job posting. */
	status: JobStatus;

	/** The location where the job is based. */
	location?: string;

	/** The name of the employer (denormalized for easy display). */
	employerName?: string;

	/** The company name of the employer (denormalized for easy display). */
	employerCompany?: string;

	/** The deadline for applying to the job. */
	deadline?: Date;

	/** The number of applications received for this job. */
	applicationsCount?: number;
}
