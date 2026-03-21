<script lang="ts">
	import { motion } from 'motion-sv';
	import { onMount } from 'svelte';
	// import logo from '$lib/assets/logo.svg';
	import logo from '$lib/assets/logo.svg';
	import { goto } from '$app/navigation';

	type NavTheme = 'dark' | 'light';

	let activeTheme: NavTheme = $state('dark');

	function readTheme(section: HTMLElement | undefined): NavTheme {
		return section?.dataset.navTheme === 'light' ? 'light' : 'dark';
	}

	function syncTheme(sections: HTMLElement[]) {
		const viewportMidpoint = window.innerHeight / 2;
		const currentSection = sections.find((section) => {
			const rect = section.getBoundingClientRect();
			return rect.top <= viewportMidpoint && rect.bottom >= viewportMidpoint;
		});

		activeTheme = readTheme(currentSection ?? sections[0]);
	}

	onMount(() => {
		const sections = Array.from(document.querySelectorAll<HTMLElement>('[data-nav-theme]'));

		if (!sections.length) {
			return;
		}

		const updateTheme = () => syncTheme(sections);
		const observer = new IntersectionObserver(updateTheme, {
			threshold: [0, 0.25, 0.5, 0.75, 1]
		});

		sections.forEach((section) => observer.observe(section));
		updateTheme();

		window.addEventListener('scroll', updateTheme, { passive: true });
		window.addEventListener('resize', updateTheme);

		return () => {
			observer.disconnect();
			window.removeEventListener('scroll', updateTheme);
			window.removeEventListener('resize', updateTheme);
		};
	});
</script>

<nav class="fixed top-0 z-50 mx-auto flex w-full justify-center p-4">
	<section
		class={`flex w-full max-w-3xl items-center justify-between self-center rounded-2xl border px-5 py-3 backdrop-blur-md transition-[background-color,border-color,box-shadow,color] duration-300 ${activeTheme === 'dark' ? 'border-white/10 bg-slate-950/30' : 'border-slate-200/80 bg-white/80 shadow-[0_12px_40px_rgba(15,23,42,0.08)]'}`}
	>
		<motion.button
			initial={{ opacity: 0, x: -20 }}
			animate={{ opacity: 1, x: 0 }}
			onclick={() => goto('/')}
			class="flex items-center gap-3"
		>
			<div class="flex h-10 w-10 items-center justify-center rounded-lg bg-[#00E676]/10">
				<img src={logo} alt="HustleLink Logo" class="h-6 w-6" />
			</div>
			<span
				class={`font-space-grotesk text-2xl font-bold transition-colors duration-300 ${activeTheme === 'dark' ? 'text-white' : 'text-[#0F172A]'}`}
			>
				HustleLink
			</span>
		</motion.button>
		<motion.button
			initial={{ opacity: 0, x: 20 }}
			animate={{ opacity: 1, x: 0 }}
			class={`rounded-lg border px-6 py-2 transition-colors duration-300 ${activeTheme === 'dark' ? 'border-[#00E676]/30 text-white hover:bg-[#00E676]/10' : 'border-slate-300 text-[#0F172A] hover:bg-[#0F172A] hover:text-white'}`}
		>
			Sign In
		</motion.button>
	</section>
</nav>
