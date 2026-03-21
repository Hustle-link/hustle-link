<script lang="ts">
	import { Send } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut } from 'svelte/easing';
	import { fly, slide } from 'svelte/transition';

	interface Props {
		name?: string;
		email?: string;
		subject?: string;
		message?: string;
		submitted: boolean;
		isSubmitting: boolean;
		handleSubmit: (event: SubmitEvent) => void | Promise<void>;
	}

	let {
		name = $bindable(''),
		email = $bindable(''),
		subject = $bindable(''),
		message = $bindable(''),
		submitted,
		isSubmitting,
		handleSubmit
	}: Props = $props();
</script>

<div
	in:fly={{ x: 36, duration: 540, easing: cubicOut }}
	class="relative overflow-hidden rounded-4xl border border-slate-200 bg-white p-8 shadow-[0_28px_90px_rgba(15,23,42,0.08)] md:p-10"
>
	<div
		class="pointer-events-none absolute top-0 right-0 h-44 w-44 rounded-full bg-[#00E676]/8 blur-[80px]"
	></div>

	<div class="relative">
		<h2 class="font-space-grotesk mb-3 text-3xl font-bold text-[#0F172A]">Send Us a Message</h2>
		<p class="mb-8 max-w-2xl text-gray-600">
			Share your question, partnership idea, or product feedback. We read every message.
		</p>

		{#if submitted}
			<div
				in:slide={{ duration: 260, axis: 'y' }}
				class="mb-6 rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700"
			>
				Your message has been queued. The HustleLink team will follow up shortly.
			</div>
		{/if}

		<!-- Form state stays in the route, but bindable props let this card own the markup. -->
		<form onsubmit={handleSubmit} class="space-y-6">
			<div class="grid gap-6 md:grid-cols-2">
				<label class="block">
					<span class="mb-2 block text-sm font-medium text-gray-700">Full Name</span>
					<input
						type="text"
						name="name"
						required
						bind:value={name}
						placeholder="John Doe"
						class="w-full rounded-2xl border border-gray-300 px-4 py-3 text-gray-900 transition-all outline-none focus:border-transparent focus:ring-2 focus:ring-[#00E676]"
					/>
				</label>

				<label class="block">
					<span class="mb-2 block text-sm font-medium text-gray-700">Email Address</span>
					<input
						type="email"
						name="email"
						required
						bind:value={email}
						placeholder="john@example.com"
						class="w-full rounded-2xl border border-gray-300 px-4 py-3 text-gray-900 transition-all outline-none focus:border-transparent focus:ring-2 focus:ring-[#00E676]"
					/>
				</label>
			</div>

			<label class="block">
				<span class="mb-2 block text-sm font-medium text-gray-700">Subject</span>
				<input
					type="text"
					name="subject"
					required
					bind:value={subject}
					placeholder="How can we help you?"
					class="w-full rounded-2xl border border-gray-300 px-4 py-3 text-gray-900 transition-all outline-none focus:border-transparent focus:ring-2 focus:ring-[#00E676]"
				/>
			</label>

			<label class="block">
				<span class="mb-2 block text-sm font-medium text-gray-700">Message</span>
				<textarea
					name="message"
					required
					rows="6"
					bind:value={message}
					placeholder="Tell us more about your inquiry..."
					class="w-full resize-none rounded-2xl border border-gray-300 px-4 py-3 text-gray-900 transition-all outline-none focus:border-transparent focus:ring-2 focus:ring-[#00E676]"
				></textarea>
			</label>

			<div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
				<p class="max-w-md text-sm text-gray-500">
					By sending a message, you agree to be contacted about your inquiry.
				</p>

				<motion.button
					type="submit"
					whileHover={{ scale: 1.02, y: -2 }}
					whilePress={{ scale: 0.98 }}
					disabled={isSubmitting}
					class="font-space-grotesk inline-flex items-center justify-center gap-2 rounded-2xl bg-[#00E676] px-7 py-4 text-lg font-bold text-[#0F172A] shadow-[0_18px_38px_rgba(0,230,118,0.24)] transition-colors hover:bg-emerald-400 disabled:cursor-not-allowed disabled:opacity-70"
				>
					<Send size={20} />
					<span>{isSubmitting ? 'Sending...' : 'Send Message'}</span>
				</motion.button>
			</div>
		</form>
	</div>
</div>
