<script lang="ts">
	import { resolve } from '$app/paths';
	import BreadCrumbNav from '$lib/components/global/BreadCrumbNav.svelte';
	import { Globe, Heart, Rocket, Target, TrendingUp, Users, Zap, Sparkles } from '@lucide/svelte';
	import { cubicOut, quintOut } from 'svelte/easing';
	import { onMount } from 'svelte';
	import { fade, fly, scale, slide } from 'svelte/transition';

	const values = [
		{
			id: 'people-first',
			icon: Heart,
			title: 'People First',
			description:
				'Every feature we build starts with understanding the needs of job seekers and employers in Botswana.'
		},
		{
			id: 'innovation',
			icon: TrendingUp,
			title: 'Innovation',
			description:
				'We use practical technology to create smarter, faster, and more accurate skill-to-opportunity matching.'
		},
		{
			id: 'community',
			icon: Users,
			title: 'Community',
			description:
				'We believe in building a supportive ecosystem where businesses, clients, and skilled people can grow together.'
		}
	] as const;

	const team = [
		{
			id: 'bolton',
			name: 'Bolton Mooketsi',
			role: 'Founder & Visionary',
			bio: 'Founder of HustleLink and the original driver of the product vision.',
			initials: 'BM',
			accent: 'from-emerald-400 to-green-600'
		},
		{
			id: 'boitumelo',
			name: 'Boitumelo Tubabwene',
			role: 'Lead Developer',
			bio: 'Responsible for building and maintaining the HustleLink platform.',
			initials: 'BT',
			accent: 'from-blue-400 to-indigo-600'
		}
	] as const;

	let reveal = $state(false);

	onMount(() => {
		reveal = true;
	});
</script>

<div class="min-h-screen bg-white">
	{#if reveal}
		<section
			data-nav-theme="dark"
			in:fade={{ duration: 350 }}
			class="bg-linear-to-br from-[#0F172A] via-[#111D33] to-[#1E293B]"
		>
			<div class="mx-auto flex min-h-[90vh] max-w-6xl flex-col px-6 pt-28 pb-16">
				<div class="relative z-20 mb-10 w-full">
					<BreadCrumbNav variant="dark" />
				</div>

				<div class="my-auto text-center">
					<div
						in:scale={{ duration: 500, start: 0.95, easing: quintOut }}
						class="mb-8 inline-flex items-center gap-2 rounded-full border border-emerald-300/40 bg-emerald-400/10 px-4 py-2 text-sm font-semibold tracking-wide text-emerald-300"
					>
						<Rocket size={16} />
						<span>Product Launch Update</span>
					</div>

					<h1
						in:fly={{ y: 28, duration: 560, easing: cubicOut }}
						class="mb-6 text-5xl font-bold text-white md:text-7xl"
					>
						Building Botswana&apos;s <span class="text-[#00E676]">Future of Work</span>
					</h1>
					<p
						in:fly={{ y: 20, duration: 620, delay: 120, easing: cubicOut }}
						class="mx-auto max-w-3xl text-lg text-slate-200 md:text-xl"
					>
						HustleLink is now launching with one goal: make it easier for people across Botswana to
						turn verified skills, certifications, and talents into real income opportunities.
					</p>
				</div>
			</div>
		</section>

		<section class="py-24">
			<div class="mx-auto grid max-w-7xl gap-12 px-6 md:grid-cols-2">
				<article
					in:fly={{ x: -36, duration: 520, easing: cubicOut }}
					class="rounded-3xl bg-linear-to-br from-[#00E676]/10 to-emerald-100/50 p-10"
				>
					<div class="mb-6 flex h-16 w-16 items-center justify-center rounded-2xl bg-[#00E676]">
						<Target class="text-white" size={32} />
					</div>
					<h2 class="mb-4 text-4xl font-bold text-[#0F172A]">Our Mission</h2>
					<p class="text-lg leading-relaxed text-gray-700">
						To simplify access to opportunity and empower people across Botswana to transform their
						hustle into sustainable income.
					</p>
				</article>

				<article
					in:fly={{ x: 36, duration: 520, easing: cubicOut }}
					class="rounded-3xl bg-linear-to-br from-blue-50 to-indigo-100/50 p-10"
				>
					<div class="mb-6 flex h-16 w-16 items-center justify-center rounded-2xl bg-blue-500">
						<Globe class="text-white" size={32} />
					</div>
					<h2 class="mb-4 text-4xl font-bold text-[#0F172A]">Our Vision</h2>
					<p class="text-lg leading-relaxed text-gray-700">
						To be Botswana&apos;s most trusted digital bridge between talent and opportunity,
						unlocking economic participation at scale.
					</p>
				</article>
			</div>
		</section>

		<section class="bg-slate-50 py-24" in:fade={{ duration: 500 }}>
			<div class="mx-auto max-w-4xl px-6">
				<h2 class="mb-10 text-center text-5xl font-bold text-[#0F172A]">About the Founder</h2>
				<article class="rounded-3xl border border-slate-200 bg-white p-10 shadow-sm">
					<div class="mb-6 flex items-center gap-4">
						<div
							in:scale={{ duration: 420, start: 0.85 }}
							class="flex h-16 w-16 items-center justify-center rounded-2xl bg-linear-to-br from-[#00E676] to-emerald-500 text-xl font-bold text-slate-900"
						>
							BM
						</div>
						<div>
							<h3 class="text-2xl font-bold text-[#0F172A]">Bolton Mooketsi</h3>
							<p class="text-slate-600">Founder &amp; Visionary</p>
						</div>
					</div>
					<p class="text-lg leading-relaxed text-gray-700">
						HustleLink was founded by Bolton Mooketsi, a Botswana entrepreneur passionate about
						building technology that connects people to real economic opportunities. Inspired by the
						everyday hustle of many talented individuals, he created HustleLink to help people turn
						their skills, certifications, and talents into real income by making opportunities
						easier to discover and access.
					</p>
				</article>
			</div>
		</section>

		<section class="py-24">
			<div class="mx-auto max-w-5xl px-6">
				<div class="mb-14 text-center" in:slide={{ duration: 450, axis: 'y' }}>
					<h2 class="mb-5 text-5xl font-bold text-[#0F172A]">About the Company</h2>
					<p class="mx-auto max-w-3xl text-lg leading-relaxed text-slate-600">
						HustleLink is a Botswana-based digital platform designed to connect people&apos;s
						skills, certifications, and talents with real earning opportunities.
					</p>
				</div>

				<div class="grid gap-8 md:grid-cols-2">
					<div
						in:fly={{ y: 26, duration: 520, delay: 80 }}
						class="rounded-2xl border border-slate-200 bg-white p-8"
					>
						<div class="mb-4 inline-flex rounded-xl bg-[#0F172A] p-3 text-[#00E676]">
							<Zap size={24} />
						</div>
						<h3 class="mb-3 text-2xl font-bold text-[#0F172A]">What the Platform Does</h3>
						<p class="leading-relaxed text-slate-600">
							The platform helps individuals find jobs, side hustles, and collaborations while
							enabling businesses and clients to quickly discover the right talent.
						</p>
					</div>

					<div
						in:fly={{ y: 26, duration: 520, delay: 150 }}
						class="rounded-2xl border border-slate-200 bg-white p-8"
					>
						<div class="mb-4 inline-flex rounded-xl bg-emerald-100 p-3 text-emerald-700">
							<Sparkles size={24} />
						</div>
						<h3 class="mb-3 text-2xl font-bold text-[#0F172A]">Why It Matters</h3>
						<p class="leading-relaxed text-slate-600">
							HustleLink&apos;s mission is to simplify access to opportunity and empower people
							across Botswana to transform their hustle into sustainable income.
						</p>
					</div>
				</div>
			</div>
		</section>

		<section class="bg-gray-50 py-24">
			<div class="mx-auto max-w-7xl px-6">
				<div class="mb-16 text-center" in:fade={{ duration: 380 }}>
					<h2 class="mb-6 text-5xl font-bold text-[#0F172A]">Our Core Values</h2>
				</div>

				<div class="grid gap-8 md:grid-cols-3">
					{#each values as value, i (value.id)}
						<article
							in:fly={{ y: 30, duration: 460, delay: 70 * i, easing: cubicOut }}
							class="rounded-2xl border border-gray-200 bg-white p-8 transition-all hover:border-[#00E676] hover:shadow-xl"
						>
							<div
								class="mb-6 flex h-14 w-14 items-center justify-center rounded-xl bg-linear-to-br from-[#00E676] to-emerald-400"
							>
								<value.icon class="text-white" size={28} />
							</div>
							<h3 class="mb-3 text-2xl font-bold text-[#0F172A]">{value.title}</h3>
							<p class="leading-relaxed text-gray-600">{value.description}</p>
						</article>
					{/each}
				</div>
			</div>
		</section>

		<section class="py-24">
			<div class="mx-auto max-w-6xl px-6">
				<div class="mb-14 text-center" in:slide={{ duration: 380, axis: 'y' }}>
					<h2 class="mb-5 text-5xl font-bold text-[#0F172A]">Our Team</h2>
					<p class="text-lg text-slate-600">A lean team committed to building real outcomes.</p>
				</div>

				<div class="grid gap-8 md:grid-cols-2">
					{#each team as member, i (member.id)}
						<article
							in:fly={{ y: 26, duration: 500, delay: i * 120, easing: cubicOut }}
							class="rounded-3xl border border-slate-200 bg-white p-8 shadow-sm"
						>
							<div class="mb-5 flex items-center gap-4">
								<div
									class={`flex h-16 w-16 items-center justify-center rounded-2xl bg-linear-to-br ${member.accent} text-xl font-bold text-white`}
								>
									{member.initials}
								</div>
								<div>
									<h3 class="text-2xl font-bold text-[#0F172A]">{member.name}</h3>
									<p class="text-slate-600">{member.role}</p>
								</div>
							</div>
							{#if member.bio}
								<p in:fade={{ duration: 300 }} class="leading-relaxed text-slate-600">
									{member.bio}
								</p>
							{/if}
						</article>
					{/each}
				</div>
			</div>
		</section>

		<section class="bg-linear-to-br from-[#0F172A] to-[#1E293B] py-20" in:fade={{ duration: 450 }}>
			<div class="mx-auto max-w-4xl px-6 text-center">
				<h2 class="mb-6 text-5xl font-bold text-white">Want to Join Our Team?</h2>
				<p class="mb-10 text-xl text-gray-300">
					We&apos;re always looking for passionate people who want to make a difference.
				</p>
				<a
					href={resolve('/download')}
					class="inline-block rounded-full bg-[#00E676] px-10 py-5 text-lg font-bold text-[#0F172A] transition-colors hover:bg-emerald-400"
				>
					Explore Opportunities
				</a>
			</div>
		</section>
	{/if}
</div>
