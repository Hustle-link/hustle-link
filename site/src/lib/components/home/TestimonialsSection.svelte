<script lang="ts">
	import { motion } from 'motion-sv';
	import { CheckCircle2 } from '@lucide/svelte';
	import type { Testimonial } from '$lib/utils/models/testimonial.models';
	import { dummyTestimonials } from '$lib/utils/dummy/dummy-testimonials';

	const testimonials: Testimonial[] = dummyTestimonials;
	const ambientOrbs = [
		{
			id: 'orb_left',
			size: '22rem',
			top: '8%',
			left: '-6%',
			background: 'radial-gradient(circle, rgba(0,230,118,0.14) 0%, rgba(0,230,118,0) 70%)',
			duration: 14,
			x: [0, 30, 0],
			y: [0, 20, 0]
		},
		{
			id: 'orb_right',
			size: '18rem',
			top: '56%',
			left: '82%',
			background: 'radial-gradient(circle, rgba(16,185,129,0.16) 0%, rgba(16,185,129,0) 72%)',
			duration: 16,
			x: [0, -25, 0],
			y: [0, -18, 0]
		},
		{
			id: 'orb_center',
			size: '14rem',
			top: '30%',
			left: '42%',
			background: 'radial-gradient(circle, rgba(15,23,42,0.08) 0%, rgba(15,23,42,0) 75%)',
			duration: 18,
			x: [0, 18, 0],
			y: [0, -16, 0]
		}
	];
</script>

<section
	id="testimonials"
	data-nav-theme="light"
	class="relative overflow-hidden bg-linear-to-br from-gray-50 to-white py-32"
>
	<div class="pointer-events-none absolute inset-0 overflow-hidden">
		<div
			class="absolute inset-0 opacity-60"
			style="background-image: linear-gradient(rgba(15, 23, 42, 0.05) 1px, transparent 1px), linear-gradient(90deg, rgba(15, 23, 42, 0.05) 1px, transparent 1px); background-size: 3.5rem 3.5rem; mask-image: radial-gradient(circle at center, black 35%, transparent 90%);"
		></div>

		{#each ambientOrbs as orb (orb.id)}
			<motion.div
				class="absolute rounded-full blur-3xl"
				style={{
					top: orb.top,
					left: orb.left,
					width: orb.size,
					height: orb.size,
					background: orb.background
				}}
				animate={{ x: orb.x, y: orb.y }}
				transition={{ duration: orb.duration, repeat: Infinity, ease: 'easeInOut' }}
			/>
		{/each}

		<div
			class="absolute inset-x-0 top-24 flex justify-between px-12 text-[10rem] leading-none font-bold text-[#00E676]/5"
		>
			<span>“</span>
			<span>”</span>
		</div>
	</div>

	<div class="relative z-10 mx-auto max-w-7xl px-6">
		<motion.div
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			class="mb-20 text-center"
		>
			<h2 class="font-space-grotesk mb-6 text-5xl font-bold text-[#0F172A] md:text-6xl">
				What Our Users Say About <span class="text-[#00E676]">Their Experience</span>
			</h2>
			<p class="mx-auto max-w-2xl text-xl text-gray-600">
				Real stories from real hustlers who transformed their careers
			</p>
		</motion.div>

		<div class="flex flex-wrap items-center justify-center gap-12">
			{#each testimonials as testimonial, testimonialIndex (testimonial.id)}
				<motion.div
					initial={{ opacity: 0, scale: 0.8 }}
					animate={{ opacity: 1, scale: 1 }}
					transition={{ delay: testimonialIndex * 0.2 }}
					class="relative"
				>
					<motion.div class="relative mx-auto mb-6 h-32 w-32" whileHover={{ scale: 1.1 }}>
						<motion.div
							class="absolute inset-0 rounded-full bg-linear-to-br from-[#00E676] to-emerald-400 opacity-20"
							animate={{
								scale: [1, 1.2, 1],
								opacity: [0.2, 0.4, 0.2]
							}}
							transition={{ duration: 3, repeat: Infinity }}
						/>
						<div
							class="relative flex h-full w-full items-center justify-center rounded-full border-4 border-white bg-linear-to-br from-[#00E676] to-emerald-400 text-6xl shadow-2xl"
						>
							{testimonial.avatar}
						</div>

						<motion.div
							class="absolute -right-2 -bottom-2 flex h-10 w-10 items-center justify-center rounded-full border-4 border-white bg-[#00E676]"
							animate={{ scale: [1, 1.1, 1] }}
							transition={{ duration: 2, repeat: Infinity }}
						>
							{#if testimonial.isVerified}
								<CheckCircle2 class="text-white" size={20} />
							{/if}
						</motion.div>
					</motion.div>

					<motion.div
						class="relative max-w-sm rounded-2xl border border-gray-200 bg-white p-8 shadow-[0_20px_60px_rgba(15,23,42,0.06)]"
						whileHover={{ y: -5 }}
					>
						<div class="absolute -top-4 left-8 text-6xl text-[#00E676] opacity-30">"</div>

						<p class="relative z-10 mb-6 leading-relaxed text-gray-700">
							{testimonial.text}
						</p>

						<div class="flex items-center gap-3 border-t border-gray-100 pt-4">
							<div>
								<p class="font-space-grotesk font-bold text-[#0F172A]">{testimonial.name}</p>
								<p class="text-sm text-gray-500">
									{testimonial.role} • {testimonial.location}
								</p>
							</div>
						</div>

						<div class="mt-4 flex gap-1">
							{#each Array.from({ length: testimonial.rating }, (_, starIndex) => starIndex) as starIndex (starIndex)}
								<motion.div
									initial={{ opacity: 0, scale: 0 }}
									animate={{ opacity: 1, scale: 1 }}
									transition={{ delay: 0.5 + starIndex * 0.1 + testimonialIndex * 0.1 }}
								>
									<span class="text-xl text-[#00E676]">★</span>
								</motion.div>
							{/each}
						</div>
					</motion.div>
				</motion.div>
			{/each}
		</div>
	</div>
</section>
