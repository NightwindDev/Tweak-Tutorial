import { themes as prismThemes } from "prism-react-renderer";
import type { Config } from "@docusaurus/types";
import type * as Preset from "@docusaurus/preset-classic";

const organizationName = "NightwindDev";
const projectName = "Tweak-Tutorial";

const config: Config = {
  title: "Tweak Tutorial",
  tagline: "Getting started with iOS Tweak development",
  favicon: "img/favicon.ico",
  url: `https://${organizationName}.github.io`,
  baseUrl: `/${projectName}/`,
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "throw",
  trailingSlash: false,
  organizationName,
  projectName,

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      {
        docs: {
          routeBasePath: "/",
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: `https://github.com/${organizationName}/${projectName}/blob/master/`,
        },
        blog: false,
        theme: {
          customCss: "./src/css/custom.css",
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: "img/docusaurus-social-card.jpg",
    navbar: {
      title: "iOS Tweaks",
      logo: {
        alt: "My Site Logo",
        src: "img/nightwind.png",
      },
      items: [
        {
          type: "docSidebar",
          sidebarId: "defaultSidebar",
          position: "left",
          label: "Tutorial",
        },
      ],
    },
    footer: {
      style: "light",
      links: [
        {
          title: "Docs",
          items: [
            {
              label: "Tutorial",
              to: "/intro",
            },
          ],
        },
        {
          title: "Community",
          items: [
            {
              label: "iOSJBN Discord Server",
              href: "https://discord.gg/K3wGBBhPqp",
            },
            {
              label: "r/jailbreakdevelopers",
              href: "https://reddit.com/r/jailbreakdevelopers",
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} NightwindDev. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
