<script lang="ts">
	import { Zap } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut } from 'svelte/easing';
	import { fade, fly } from 'svelte/transition';
	import type { ContactMethod, SocialLink } from './contact.types';

	interface Props {
		contactMethods: ContactMethod[];
		socialLinks: SocialLink[];
	}

	let { contactMethods, socialLinks }: Props = $props();
</script>

<div class="space-y-8">
	<!-- Contact methods stay isolated here so other pages can reuse the same support card pattern. -->
	<div
		in:fly={{ x: -36, duration: 500, easing: cubicOut }}
		class="rounded-3xl border border-slate-200 bg-white p-8 shadow-[0_20px_70px_rgba(15,23,42,0.06)]"
	>
		<h2 class="font-space-grotesk mb-8 text-3xl font-bold text-[#0F172A]">Contact Information</h2>

		<div class="space-y-6">
			{#each contactMethods as method, index (method.id)}
				<div
					in:fly={{ x: -20, duration: 420, delay: index * 90, easing: cubicOut }}
					class="flex items-start gap-4"
				>
					<div
						class="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-[#00E676] text-white shadow-[0_12px_24px_rgba(0,230,118,0.28)]"
					>
						<method.icon size={20} />
					</div>

					<div class="min-w-0">
						<h3 class="font-space-grotesk mb-1 text-lg font-bold text-[#0F172A]">
							{method.title}
						</h3>

						{#if method.id === 'email'}
							<a
								href="mailto:support@hustlelink.bw"
								class="text-gray-600 transition-colors hover:text-[#00E676]"
							>
								{method.description[0]}
							</a>
						{:else if method.id === 'phone'}
							<a
								href="tel:+26771234567"
								class="text-gray-600 transition-colors hover:text-[#00E676]"
							>
								{method.description[0]}
							</a>
						{:else}
							<p class="text-gray-600">{method.description[0]}</p>
						{/if}

						{#if method.description[1]}
							<p class="text-gray-600">{method.description[1]}</p>
						{/if}
					</div>
				</div>
			{/each}
		</div>
	</div>

	<div
		in:fade={{ duration: 520, delay: 180 }}
		class="overflow-hidden rounded-3xl bg-[#0F172A] p-8 text-white"
	>
		<div class="mb-6 flex items-center gap-3">
			<div class="rounded-2xl bg-[#00E676] p-3 text-[#0F172A]">
				<Zap size={22} />
			</div>
			<div>
				<h3 class="font-space-grotesk text-xl font-bold">Follow Us</h3>
				<p class="text-sm text-slate-300">Stay close to launch updates and new roles.</p>
			</div>
		</div>

		<div class="grid grid-cols-2 gap-4">
			{#each socialLinks as social (social.id)}
				<motion.a
					href={social.href}
					whileHover={{ y: -4, scale: 1.02 }}
					whilePress={{ scale: 0.97 }}
					class="group rounded-2xl border border-white/10 bg-white/6 p-4 transition-colors hover:border-[#00E676]/50"
				>
					<div
						class={`mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-linear-to-br ${social.accent} text-sm font-bold text-white`}
					>
						{social.label[0]}
					</div>
					<p class="font-space-grotesk font-bold">{social.label}</p>
					<p class="text-sm text-slate-300 group-hover:text-white">Join the conversation</p>
				</motion.a>
			{/each}
		</div>
	</div>
</div>
