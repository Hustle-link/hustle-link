import type { Testimonial } from '$lib/utils/models/testimonial.models';

export const dummyTestimonials: Testimonial[] = [
	{
		id: 'testimonial_001',
		name: 'Kago Moalosi',
		role: 'Frontend Developer',
		location: 'Gaborone',
		avatar: '💻',
		text: 'HustleLink helped me move from freelance uncertainty to a steady contract pipeline in less than a month.',
		rating: 5,
		isVerified: true
	},
	{
		id: 'testimonial_002',
		name: 'Naledi Motsumi',
		role: 'Solar Technician',
		location: 'Francistown',
		avatar: '☀️',
		text: 'The platform surfaced roles that actually matched my certifications instead of wasting time with generic listings.',
		rating: 5,
		isVerified: true
	},
	{
		id: 'testimonial_003',
		name: 'Thabo Segokgo',
		role: 'Graphic Designer',
		location: 'Maun',
		avatar: '🎨',
		text: 'I landed two interview calls within a week, and employers already understood the kind of work I was qualified for.',
		rating: 5,
		isVerified: true
	}
];
