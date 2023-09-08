Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF12E798159
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Sep 2023 06:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjIHEtM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Sep 2023 00:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjIHEtL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Sep 2023 00:49:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3761990;
        Thu,  7 Sep 2023 21:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694148546; x=1725684546;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=bXvdR5B4NKDnac6t0Bs1PqH4w3JI00qhEFcUHT0maFg=;
  b=TxuGN+a4CXpoLrAA+xOrwSmVLtQmJ0dSixnHP7+hlzhOYzl5OIiT2/VB
   6leXkdV6zlLEc3Bbuj+7CJyTQTPn4qEjcmezXgt8T0ERuOT4XcscsiCps
   zuOrzk7FI2WmfSsnfUD1amslGChBWJlndiYHeSq6Va/+trPLYBxkcA6cr
   ATr7Vasbqx1oI1kzv+RqBSnZWBqW5QoOQz7SJIMqhIar0r4ygPTT+XgVu
   rJzcIYPG+7bPF696FdNP+nXzWfgcZUz5fAo0tFb/yzZKJUDxvyPQPOZaB
   jZ62KZLFi+m0uFcjLYQtW8Tdu9RI8zOFc1UeLydsuo1YsvlnxZ7ZnBryO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="374941118"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="374941118"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="745470950"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="745470950"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 21:49:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 21:49:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 21:49:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 7 Sep 2023 21:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvH4+LIX86SHme2tjSWY5aSbUoCMRZv8f7/dGQOUV/knpEY0MCbCCH+hmSaiOP/LHjT2zloVfB2AbckjielUxDzFbNmjfeJ1iFjse9YCoAEkZSujqYzx2G9BdKN8exFoDoRK38y3VRdB5GU8UQHYsavCqlU697c/p42r/9HRF1+/vT15MUtJQD6dHAvOyvCQK1DTUqmBXmscu7xSmrP/stj9Leko1mwFZzLjLvELdt+FuTOdMxDBo0bIlyRpQDdbgA2vZRNoyIwOFZM3ITElmWmKL39x9UBcQMdA155MPBLiJaKhKfTXInuZfwLnIVEiWgx2QPBdnfn2XCyq3J6eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfXTt2cxpLJMFH4gCwh/qhjmC1zi639O3iToNrmtbC8=;
 b=gGz54JsF+MrIs2HaIFcJNPMUhMHmLjI6bMCEWBdZVy/iua0DlbJHOzIADZZ9YtaY4S7gKWI2IolKWx6IGXtwRw+Kyr+GgEAFaqgMxPTUOkujumcSkHu6vrGyanuTdBXqaoB5oufm8AywjxJwGasiZHw593iW6SUtaLwGqhp6LAzPVAJnbIBVB7eHkBQqLTgU+hQXVAEXOVUnAfI8Zg2pZh4u1Ka4KVjY5ENgH0YQmCzWG/FbQZ9CI5Iqusrwf0WB7H5ZASm3Kbo7qDpWp8iVulw9xWCMxtagHLic+X/DRCC7QzzNmE4yJoKM6r1Y9etUYIwPTjh4XioB+wrB41VqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 04:49:02 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 04:49:02 +0000
Date:   Fri, 8 Sep 2023 12:48:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH net] sctp: fix uninit-value in sctp_inq_pop()
Message-ID: <202309081012.be01cf11-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829071334.58083-1-n.zhandarovich@fintech.ru>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fec114-27ac-445b-15bb-08dbb026eb53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8l9fqKPegHBsCywiiwHWm2V1biDWj3Z+4lYRtDg2vat+OgBJPYuMttI8knW/Kym+KYB8FLIsIgbM3ORXPyU1FyrscqfnNMNkz5BHR+L4CLbDj3cbYJvV5SEUWmSNHko75iljM0jUHlnb+jkle8/cpcvMtSmhWvxoM+1KhgN1GloPa+eEdpLJ/oKj8oBhxH1eb0cjJSC1faaq7QaA33WTaUHGcdgHLGV2/OTMrMq4Iqlu0iwnuyfun7QrbuYQm8CdMiOVJS64Yzbf1actcMj9hzgYgxqA6I1zWTczkjo42pJDbvTCVvfXQns2lzc0Jnf2qR+zqy/WUuZT4skBT7uYgOShmNYu3SRxv94aejVXpxnKZzwyGeEhTN2c/qQ1Q21ydU6YKJ/xKX0es+rZ3cxwWq/G+maRyusx5h7mI3+M38TDEuo+WwlZdo3vSR8jYNAhow0FcHYloi5YyAlsqljtxU+70hHhgdWQo+qwPE9ayO8Lepl4ByzGlcPjkkBIv5w4Et08E10Xb0WsNQLf1HYmPFSUhHu/VivN7yHDQGmn0+93fmPUNo0lNU//FQMEc2J3NosjZhb3GQX0wxJnEamsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(478600001)(5660300002)(66476007)(66946007)(66556008)(54906003)(966005)(6916009)(83380400001)(316002)(8676002)(2906002)(4326008)(8936002)(6666004)(41300700001)(7416002)(6486002)(6506007)(6512007)(107886003)(2616005)(1076003)(26005)(36756003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWniYioiCDpOge6LjANNKfSPECMfKpqtgoq8QPEXkgL6sBovpryU6CO48jAt?=
 =?us-ascii?Q?tYZi337jwWpto4ZWhlIHWtjycYbRKwSyZlOwRAAMU01LJNlT3TLFI5nMCCny?=
 =?us-ascii?Q?zPRCqOt9M1/ikY4fwIF3mKFprPskdA+AHkPVD4v+cr457ICpYR3u/CJiesEO?=
 =?us-ascii?Q?6KamYCXMBLztz/oBW2+vKTGXBBgRij4h453DvYWx8qvG15UnmBwAToz5j+98?=
 =?us-ascii?Q?DGeF+HcUMYs35YtjqYvVe0SlBexB2r6d/nHDe5Bg/NSwRXLX5JKhKp+e9AAh?=
 =?us-ascii?Q?baAH+xoT0yPjjxye3pyyglREWJaBIyQVv2SkA+kVwfbIGu4EKyKIXaIyBa56?=
 =?us-ascii?Q?zLFI5UpxbOVIlJpIZRmdLkO8cir5fX68hPI177R2+u5+Bo5/m49wDUpEYb0V?=
 =?us-ascii?Q?cktf5MOs7vbJ2RXcblEAlPSA5gfekT473+i92xj0mpcyv0RaiUA54nYl+pl9?=
 =?us-ascii?Q?6hwedGMmx5Ih88DRzt5eMXwJZVjdt9bK+d/7XHf5YIT9gVegvq1C6O0QoUds?=
 =?us-ascii?Q?MACtpWMlLINQ4Pz4sQDDTWVn9kkbnyJqfkLC+U04Db10aO/THipuCQvmgVgx?=
 =?us-ascii?Q?6qeDQyESgkD0FrN+m335EoOwIFV3WSDKWh6mP4yDqdwhVwVZ3EwicJocsxY5?=
 =?us-ascii?Q?fZDCf8xz7Rg9lsyrEU0vp8ITrpmmh7PD3quFxdS/ZYFgYA2Rlt63Z8XBC3JA?=
 =?us-ascii?Q?ZGUszj0FQz/dax0488jIpByJGZUdppumJwcgiTMir/JRAMVYhZXKBqQ3rve1?=
 =?us-ascii?Q?rMLrRACjFtjsOIA7N0UtVsx8HyK8+C6ep9TaG7kbrV0U1XIqK9yHCp48/4VQ?=
 =?us-ascii?Q?MwjuCMso91tZFSwO48bvkZVxgHgfGxDXFE6Zn08rb00iOXIY5Xdm0iHDzfZS?=
 =?us-ascii?Q?fXTdVbBhIgm+01ViUpb7cEPVA8eDYrQlwYnTGwCWPZAhMRWz+iXijx1ap1Gi?=
 =?us-ascii?Q?WIsysvON9BJFwnrcqSVxFNYU/siaNUAVlkk4Q4hq9CXNIRTWR3Q5Kst4t5wY?=
 =?us-ascii?Q?X284fd/qYzYQn/+RWimUgMjCT5v5V0Uo+WaYl4vls7HMCeiGMBQtH1fW2zR1?=
 =?us-ascii?Q?umYX6/atzNck7THABVMl/U2Ydo/rVCGl5+VaXoRKtkSeYZx+Iz+W6Sl4H2HP?=
 =?us-ascii?Q?phrnQlUsLETQADXicRJToroBmlWIiQmhCzuOu45HA7aQpozR1bb87TNIHQ8I?=
 =?us-ascii?Q?Q/CmLS5d5DwqfYRSOtjnGLWzcYv0+n0yw0OZBvcm88Y2zfeSIB2gzcht1sWX?=
 =?us-ascii?Q?dJTLDzxnJ92lV3bRUR33juymNNnT/kUeQUfhXjEJBQs4h0tPTZVXNvjSGOfD?=
 =?us-ascii?Q?xkArtCbVXukE7fQ84V3H4SgYhUcJCbRaars/UpXgSZZDQUTAA+tEi7H7Um7D?=
 =?us-ascii?Q?B3qz/lEvYx5AhvAJ7Xd5jxZ/u8IkKCFgbzM95gLA1thqs1bj0P5kC7Ev+U4r?=
 =?us-ascii?Q?Uo7a7ZnBt2ndZUcPC90XjwP9w+dyMM6C7zNwUvoSX4idWwaEe80kRRUIrs7+?=
 =?us-ascii?Q?mzNIQP8nW5/FpB/iMGNVSukc9VLimTCWJS4qoOuhIyVGrf1twAZ+fqBe7BHp?=
 =?us-ascii?Q?cBxn8mog5rAXk69zyuqPNv47s8PuJv48fVTK2+GF8/k4GNkwNUroHGWwW4/c?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fec114-27ac-445b-15bb-08dbb026eb53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 04:49:02.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBACLqaHckPZM3Y4UdIvlE+saZARzEjBmMQ9CPTMyZEyhBmwczERvXMK6khlG99stO7aVuyXpl7vPtCDvJLcCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



Hello,

kernel test robot noticed "stress-ng.sctp.fail" on:

commit: 8c7dea932ab60ed7519996ade2d1e21db2c76cd4 ("[PATCH net] sctp: fix uninit-value in sctp_inq_pop()")
url: https://github.com/intel-lab-lkp/linux/commits/Nikita-Zhandarovich/sctp-fix-uninit-value-in-sctp_inq_pop/20230829-151540
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 90ca51e8c654699b672ba61aeaa418dfb3252e5e
patch link: https://lore.kernel.org/all/20230829071334.58083-1-n.zhandarovich@fintech.ru/
patch subject: [PATCH net] sctp: fix uninit-value in sctp_inq_pop()

in testcase: stress-ng
version: stress-ng-x86_64-0.15.04-1_20230812
with following parameters:

	nr_threads: 100%
	testtime: 60s
	class: network
	test: sctp
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309081012.be01cf11-oliver.sang@intel.com

2023-09-07 16:33:40 stress-ng --timeout 60 --times --verify --metrics-brief --sctp 64
stress-ng: info:  [4148] setting to a 60 second run per stressor
stress-ng: info:  [4148] dispatching hogs: 64 sctp
stress-ng: info:  [4148] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [4148]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [4148] sctp                  0     60.00      0.03      0.01         0.00           0.00
stress-ng: warn:  [4148] metrics-check: all bogo-op counters are zero, data may be incorrect
stress-ng: info:  [4148] for a 60.01s run time:
stress-ng: info:  [4148]    3840.71s available CPU time
stress-ng: info:  [4148]       0.04s user time   (  0.00%)
stress-ng: info:  [4148]       0.01s system time (  0.00%)
stress-ng: info:  [4148]       0.05s total time  (  0.00%)
stress-ng: info:  [4148] load average: 0.63 0.32 0.12
stress-ng: info:  [4148] successful run completed in 60.01s (1 min, 0.01 secs)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230908/202309081012.be01cf11-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

