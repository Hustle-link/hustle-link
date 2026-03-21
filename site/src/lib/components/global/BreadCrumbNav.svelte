<script lang="ts">
	import { resolve } from '$app/paths';
	import { page } from '$app/state';
	import { ChevronRight, House } from '@lucide/svelte';
	import { motion } from 'motion-sv';

	export interface BreadcrumbItem {
		label: string;
		href?: string;
	}

	type Variant = 'dark' | 'light';

	interface Props {
		items?: BreadcrumbItem[];
		homeLabel?: string;
		homeHref?: string;
		variant?: Variant;
		class?: string;
	}

	let {
		items,
		homeLabel = 'Home',
		homeHref = '/',
		variant = 'dark',
		class: className = ''
	}: Props = $props();

	const autoItems = $derived.by(() => {
		const path = page.url.pathname;
		const segments = path.split('/').filter(Boolean);

		if (!segments.length) {
			return [{ label: homeLabel }];
		}

		const generated: BreadcrumbItem[] = [{ label: homeLabel, href: homeHref }];
		let currentPath = '';

		for (const segment of segments) {
			currentPath += `/${segment}`;
			generated.push({
				label: decodeURIComponent(segment)
					.replace(/[-_]+/g, ' ')
					.replace(/\b\w/g, (char) => char.toUpperCase()),
				href: currentPath
			});
		}

		generated[generated.length - 1].href = undefined;
		return generated;
	});

	const crumbs = $derived(items?.length ? [...items] : autoItems);

	function resolvedHref(href: string) {
		return resolve(...([href] as unknown as Parameters<typeof resolve>));
	}
</script>

<motion.nav
	aria-label="Breadcrumb"
	initial={{ opacity: 0, y: -10 }}
	animate={{ opacity: 1, y: 0 }}
	transition={{ duration: 0.4 }}
	class={`w-full rounded-2xl border px-4 py-3 backdrop-blur-md transition-[background-color,border-color,color,box-shadow] duration-300 md:px-5 ${
		variant === 'dark'
			? 'border-white/12 bg-slate-950/40 text-slate-100'
			: 'border-slate-200/80 bg-white/80 text-slate-700 shadow-[0_10px_28px_rgba(15,23,42,0.08)]'
	} ${className}`}
>
	<ol class="flex flex-wrap items-center gap-1.5 text-sm md:text-base">
		{#each crumbs as crumb, i (`${crumb.label}-${crumb.href ?? 'current'}-${i}`)}
			<li class="flex items-center gap-1.5">
				{#if crumb.href}
					<motion.a
						href={resolvedHref(crumb.href)}
						whileHover={{ scale: 1.02 }}
						whilePress={{ scale: 0.98 }}
						class={`inline-flex items-center gap-1.5 rounded-lg px-2 py-1 transition-colors duration-200 ${
							variant === 'dark'
								? 'text-slate-300 hover:bg-white/6 hover:text-[#00E676]'
								: 'text-slate-500 hover:bg-slate-100 hover:text-slate-900'
						}`}
					>
						{#if i === 0}
							<House size={16} />
						{/if}
						<span>{crumb.label}</span>
					</motion.a>
				{:else}
					<motion.span
						initial={{ opacity: 0, y: 4 }}
						animate={{ opacity: 1, y: 0 }}
						transition={{ delay: i * 0.04, duration: 0.25 }}
						aria-current="page"
						class={`inline-flex items-center gap-1.5 rounded-lg px-2 py-1 font-semibold ${
							variant === 'dark' ? 'text-[#00E676]' : 'text-slate-900'
						}`}
					>
						{#if i === 0}
							<House size={16} />
						{/if}
						<span>{crumb.label}</span>
					</motion.span>
				{/if}

				{#if i < crumbs.length - 1}
					<motion.span
						initial={{ opacity: 0, x: -3 }}
						animate={{ opacity: 1, x: 0 }}
						transition={{ delay: 0.08 + i * 0.05, duration: 0.2 }}
						class={variant === 'dark' ? 'text-slate-500' : 'text-slate-400'}
					>
						<ChevronRight size={15} />
					</motion.span>
				{/if}
			</li>
		{/each}
	</ol>
</motion.nav>
