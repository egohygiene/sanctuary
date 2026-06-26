import rss, { type RSSOptions } from "@astrojs/rss";
import { getSynapses, type SynapseRow } from "../lib/getSynapses";
import { SITE_TITLE, SITE_DESCRIPTION } from "../consts";
import type { APIRoute } from "astro";

export const GET: APIRoute = async ({ site }) => {
        const posts: SynapseRow[] = getSynapses();

	const feedOptions: RSSOptions = {
		title: SITE_TITLE,
		description: SITE_DESCRIPTION,
		site,
		items: posts.map((post) => ({
			title: post.title,
			pubDate: new Date(post.created),
			description: post.content.slice(0, 120),
                        link: `/synapse/${post.slug}/`,
		})),
		customData: `<language>en-us</language>`,
	};

	return rss(feedOptions);
};
