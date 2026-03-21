<script lang="ts">
	import logo from '$lib/assets/logo.svg';
	import { page } from '$app/state';

	type SeoMeta = {
		title: string;
		description: string;
		keywords: string;
	};

	const defaultMeta: SeoMeta = {
		title: 'HustleLink | Botswana Skills and Opportunity Platform',
		description:
			'HustleLink connects Botswana job seekers and employers through verified skills, smart matching, and practical hiring tools.',
		keywords: 'HustleLink, Botswana jobs, skills matching, careers, employers, hustlers'
	};

	const routeSeo: Record<string, SeoMeta> = {
		'/': {
			title: 'HustleLink | Botswana Skills and Opportunity Platform',
			description:
				'HustleLink connects Botswana job seekers and employers through verified skills, smart matching, and practical hiring tools.',
			keywords: 'HustleLink, Botswana jobs, skills matching, careers, employers, hustlers'
		},
		'/about': {
			title: 'About HustleLink | Product Launch - Botswana Skills and Opportunity Platform',
			description:
				'HustleLink is launching as a Botswana-built platform connecting skills, certifications, and talents to jobs, side hustles, and collaborations.',
			keywords:
				'HustleLink, Botswana jobs, side hustles, skills platform, founder Bolton Mooketsi, Botswana opportunities'
		},
		'/contact': {
			title: 'Contact HustleLink | Speak With the Team',
			description:
				'Contact the HustleLink team for support, partnership questions, and launch updates from Botswana and beyond.',
			keywords:
				'HustleLink contact, Botswana jobs support, HustleLink email, HustleLink phone, career platform contact'
		},
		'/download': {
			title: 'Download HustleLink | Get App on iOS, Android and Huawei',
			description:
				'Download HustleLink on iOS, Android, or Huawei devices and access Botswana job opportunities from your mobile.',
			keywords: 'HustleLink app, download app, Botswana jobs app, iOS, Android, Huawei'
		},
		'/help': {
			title: 'Help Center | HustleLink Support and FAQs',
			description:
				'Search the HustleLink help center for onboarding guidance, application support, and account security answers.',
			keywords:
				'HustleLink help, HustleLink support, job seeker FAQ, Botswana careers help, account security help'
		},
		'/privacy-security': {
			title: 'Privacy and Security | HustleLink Botswana',
			description:
				'Learn how HustleLink Botswana protects personal information, secures accounts, and manages data across Firebase services.',
			keywords:
				'HustleLink privacy, HustleLink security, Botswana data protection, Firebase security, Botswana jobs app privacy'
		},
		'/demo': {
			title: 'Demo | HustleLink',
			description:
				'Explore HustleLink demo pages and testing routes used for product previews and quality checks.',
			keywords: 'HustleLink demo, Svelte demo, product preview, testing routes'
		},
		'/demo/playwright': {
			title: 'Playwright Demo | HustleLink',
			description: 'Playwright end-to-end demonstration page for HustleLink quality assurance.',
			keywords: 'HustleLink playwright, e2e testing, QA demo'
		}
	};

	const normalizedPath = $derived.by(() => {
		const pathname = page.url.pathname;
		return pathname.length > 1 && pathname.endsWith('/') ? pathname.slice(0, -1) : pathname;
	});

	const meta = $derived(routeSeo[normalizedPath] ?? defaultMeta);
	const canonicalUrl = $derived(`${page.url.origin}${normalizedPath}`);
</script>

<svelte:head>
	<link rel="icon" href={logo} />
	<title>{meta.title}</title>
	<meta name="description" content={meta.description} />
	<meta name="keywords" content={meta.keywords} />
	<meta name="robots" content="index, follow" />
	<link rel="canonical" href={canonicalUrl} />

	<meta property="og:type" content="website" />
	<meta property="og:title" content={meta.title} />
	<meta property="og:description" content={meta.description} />
	<meta property="og:url" content={canonicalUrl} />
	<meta property="og:site_name" content="HustleLink" />

	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content={meta.title} />
	<meta name="twitter:description" content={meta.description} />
</svelte:head>
