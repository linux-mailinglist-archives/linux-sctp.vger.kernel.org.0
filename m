Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7835B52E3E0
	for <lists+linux-sctp@lfdr.de>; Fri, 20 May 2022 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiETEg1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 20 May 2022 00:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiETEgZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 20 May 2022 00:36:25 -0400
X-Greylist: delayed 925 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:36:01 PDT
Received: from CN01-SHA-obe.outbound.protection.partner.outlook.cn (mail-shahn0102.outbound.protection.partner.outlook.cn [42.159.164.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF91CB05;
        Thu, 19 May 2022 21:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXEcO+Pdq/n1WvMeexF9+Z31kqpVfOcFE3Aesh90bbg+/7P+xsxoBW/DLK5bvP90mOjIaElKZoGTskWbdu5jIqk9cvMs3/vbugqPO8AvHvxeEE1yLrZqMqzbBhJhedfDsI9Zfsz8m8IdhuKnHW5gqeJFIwLeNl6D1/Auqj+xWrQA7OdYI+5QGHBZC27kh/aNklxYOsQ3Amn99jgXzKhKMGMEZwp7xS9Ksz5Bg02yCr8YNpj/6JTYlWjtEE5pcKrrN7bRXWpkOIY1jI0a76frjYIWJyKSZe+hnd6OLMuNpXnMMTKQEMLBH9h4blcawroZ1SehuszmClTKEgDmDnoyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=ILTGm3Q6NIH5XdXAZ+IfHIETfVywtvN/v3gcaxksgAM3mS3PNnQ+WVtyGZMG0n7tVq2MNchb9cHvNyJyDrgk3Bb5mIMu/iMp48EKEDODBLB0oh04yJ2t6n/cXh8BliF/fz77Fi+J/ysPbUhf8IBnEvDVLHbhueNYnNcxmvHJaKySq9FjPWhj+6oM76PWesTEtYCp+HCGjVUPJ7Kj5P8rv/tIP2w+J/uUT9lY4vHFbhnbYx95/NE0E1Rpb6Kdg/uZTllP+XnE0AbtZBQsNw8dNARiGq/n6e6UF3pNrse0k12/p1MN0lzXRJ2g3UYcj7KcS3I2LG+TH/6NtdcJ7pX39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=jTCnGgYd5svKDIgJS9NV/88sq8Y9hmymhPgnlZZjNOCxqr//9M3N2QMl57U55yJktd+owUV7q4boMlhawhy3dEQ0gbZxcD8SgAR/XRlpKXDgvr9z7vBgXBVvFaWczZCiKk6YpkGpfSzryh0TJFvz08wRvNrUcBBduTxZrD6Bc5GOVhCI1mbV+hx+P9AwGjmEXny/JpGIFaZCHs3/kT/Zva3BPssgsLtH2jXFcV2pTHQdvHI9gs6GExlSE004piC+eVNLKiTiwc5znWZefjtLGeDvhYPFsBFH1LM06/3hnuTuR/n+zQjd4vcQbGjCM5N00TRE7zbqDw49XuW2mTt56w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0575.CHNPR01.prod.partner.outlook.cn (10.43.109.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 04:19:19 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:19:18 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:16 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0008.CHNPR01.prod.partner.outlook.cn
 (10.43.34.148) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB0623E230C4C6B93FC36AEA8A89D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e838114-9218-4390-0b40-08da39141e52
X-MS-TrafficTypeDiagnostic: SHXPR01MB0575:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB05756F79FD9BAB2C43C4105389D39@SHXPR01MB0575.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cDc3RMniuYXuNYZ7JQwjTu5F8HvWC5XYKB4cujm5KVV147U6AG93bkHoOL?=
 =?iso-8859-1?Q?fzSWaGsm+QTvATZmM8pNOO07H01F/eHp0dV9/akZeOY3k428Hd3+1fvpvS?=
 =?iso-8859-1?Q?ByJBIH2Lb7/0zSGebK+UuaHyVADhrIcGw0eL9NsvTNgQhzE2BWMpws8fNt?=
 =?iso-8859-1?Q?TKBeKuW8esCnwO63bEMk5wApwQjSI0BMJ6Y+2kC4xB1NCsiWTSqZbYLxSt?=
 =?iso-8859-1?Q?NzMaArLcsNe4/aTH6CI3LOYaqVziTv/YFnvJe9/hCccru/LZxoLddoyxwe?=
 =?iso-8859-1?Q?qQey5cTMM13ZJQ/jDCW/gz5iOucIMS5P0X0N2Jk2n2ynmk8Vh2dqnK48ph?=
 =?iso-8859-1?Q?dk+pUrwqYxqOEQXJkfe8ai4jU0R1GiqxW00Gt/KLm0QlZux03a2EAqLg2V?=
 =?iso-8859-1?Q?CkfORNJNJpPTPyBsHJOlQYDLcutp8EtBc+vs1Wm9J/tRPMjkcBF7XmB/bD?=
 =?iso-8859-1?Q?yqb2UbPpt1jUof7s0Bq7nTiXQ01WvpbyLe4p8bo7oXUzIpk2e1T9XsLREH?=
 =?iso-8859-1?Q?jkq4JUq694l/oaEcPMM8hrkKefQKnaCC2dmri/sKVd3L04cmWqBOHBm0DL?=
 =?iso-8859-1?Q?c5B+7vwDaZzdZbWRkSey69NrdLVKaSUxjawgvIToBuqwzTYlSwnuE1U9Ou?=
 =?iso-8859-1?Q?52yujYKcxzpVHDeCIl8+Ky9qDhEdTLVCbRTo1xVJvY8+cZVaOyP7qxgzl8?=
 =?iso-8859-1?Q?fwRBlmP7eUBADQBRSXTYdlmJeUzo7hsqNBTRykFQplmB48Q+F1dDLXMHVn?=
 =?iso-8859-1?Q?H7O8faOSoml+g80qeZByq8zZvNA7ckrHexNSbkVBPTLJg7C+cYZ8DZaJC6?=
 =?iso-8859-1?Q?9+78SZZLEWnBk0dWANZbOanlUG4u5dQDN7atZs1mFp/D44RkPeYAnqUZeg?=
 =?iso-8859-1?Q?dEQtof3QrmQurLwLBsXcuiWmtElS6oyNFxrw921HbAR/01pe1066DfJBNK?=
 =?iso-8859-1?Q?LD60m9PK82U1QbZcAoQqlLo/G+FROFQ6qOWONrEB5EdmdWe7du9+XLSyYT?=
 =?iso-8859-1?Q?EQQ5pp6Eja/ctpvIkYuvk6KN5Ixc7vy21ktPf6MhyCJZmWobqxg0P+m40e?=
 =?iso-8859-1?Q?6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(7696005)(52116002)(40160700002)(19618925003)(38100700002)(6200100001)(558084003)(38350700002)(26005)(8936002)(8676002)(4270600006)(40180700001)(9686003)(6862004)(66946007)(7406005)(66556008)(7416002)(55016003)(7366002)(66476007)(186003)(86362001)(2906002)(508600001)(7116003)(3480700007)(33656002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AGwfZK7TovS4xeVVHEyToXgBBA7/cl3q9gERs1/gudfOZtwEitm5+D9BmE?=
 =?iso-8859-1?Q?lJEAEjt3XpTs6TQQF38cYPhOhC0gSVKDom4op8B+T9mD3f3qeW1SEdZNRo?=
 =?iso-8859-1?Q?J1A/xXu9jMwpEnzvBBUhksUoc24JercKG+lzFOxlqr58GMouHyReIgxs3p?=
 =?iso-8859-1?Q?Zi9esPFmo5hWwHlk0Fy94BRZjnRhi9Txn+gtrm5dtZA4J0gu1zxo5ppPfF?=
 =?iso-8859-1?Q?DoUx6WZ8IbBYGltIFDJAdAKVfVTswSwOSxXkS9JncvA8QqowMkv0FKkVRl?=
 =?iso-8859-1?Q?PeFJfIeNhBb0w4N7QjlWfS0da7GJcW8mGPAhORTyWMmMuUJwjRA16JuzRn?=
 =?iso-8859-1?Q?B23v0c4IkglY6t9IYFZ8Wi6AvdIwlV7lScLCgkkNTBzwpzls11UAOwwiio?=
 =?iso-8859-1?Q?IDjRL4+xWF0QjJew2x4LVjHmxWFYUQ/EWn4CCYESjAvUdoj8Qwa9ZVYUST?=
 =?iso-8859-1?Q?FYKrg1bFjuNwlGE4mfAEua9O5Fk6woExeWJvZs8Mn6CBI2tzjDJwJYpx52?=
 =?iso-8859-1?Q?4hCOZMW8ozfTEOeu95Y0oXsPmCQil3SdaGULRd8Wjg6yRddM9nH/1RWjR1?=
 =?iso-8859-1?Q?KPOdaup0ZiF+lpp8JjQ0vz7KbIeLiD3Nf6f+djFxJtfo/Tx4i4q+3LHbOa?=
 =?iso-8859-1?Q?IfqrVRi/NcdI/0QzfFq/t6JDYMSxiEEtJKjNZzTsfAirwdsABhCJDeVCHe?=
 =?iso-8859-1?Q?DOtvBQ81BoX3THumlEfPCkvU2SasnIwUHaqNKpM1E+OOxG+09jPt4cozex?=
 =?iso-8859-1?Q?PP21g21qbJlbDW7y0Dln48TNfin4La3q7XPWK/Y0+n7sulVxvAmGozTlry?=
 =?iso-8859-1?Q?a/ndxmoCRWjZ6h9u89I8QQ0DXR0t+iIpIkJdO80vynlfJvz7dHPBzCCOiL?=
 =?iso-8859-1?Q?YcHeCFcZH40IBwuHPJU0zAtoKnAl6O/nNKo+swTlC4IATkI5XJiCJqgLQ4?=
 =?iso-8859-1?Q?ARQDiivNf2fHnvzzF6LgNcJMBwmEzI3u+u6XQCJ30nshYtiaYb4rDVT4JF?=
 =?iso-8859-1?Q?oBcN3PRFaZGjJTvwc8kmAf4M6TAGQ8h3OMdIjwyPQD3C0M3NWVwNOff7f8?=
 =?iso-8859-1?Q?ATBrqqDcyMRGMxlL5fUZx41XwXN/jHcXDwUPbhJmIO/zWhTdRafCDNjgCm?=
 =?iso-8859-1?Q?UmbB6tV13gVYE+5ToOiB5XWb3HYclvDS4jOxHmiICodEpbCQTdLjNnbdcg?=
 =?iso-8859-1?Q?mglnvKn/jaHF2DAKhyT2Pg475M02dSZ+kETcKTsWVhIstIjpeExnLRfJZW?=
 =?iso-8859-1?Q?55XG8Y2V0LTO5k1aReCMrY123LAZ84GXTMYloiIJZmSLYqNHOOZ7uPubUS?=
 =?iso-8859-1?Q?mLLGVohhDaCKYiBfG7NWOCHcy538lyZMzzqirahUuOihYijYiB/e0+1MJ8?=
 =?iso-8859-1?Q?5pusmQOHNf7zrK5TnaQMRfkQQ689sL02p1ZbKECYttBMarthbQ3vJWTuJo?=
 =?iso-8859-1?Q?gL/lc4G+auQ2/uY32AZjL23aHgbG1/7lj0iXY7/3fhEDVJvOUXYoBD+s0K?=
 =?iso-8859-1?Q?s51wSdE3da125p78VKYlI5p/McXJqDdKUVJ1hhtttgShoG9oKHprI7UIPU?=
 =?iso-8859-1?Q?U3NkMgQ8CgXQxpI23VR38i7VWEC8GJcwtMwDgsDFNUAD5xz6QosecTFY+T?=
 =?iso-8859-1?Q?UiLddoHdM4IesAAv5FIl9Pcl9FiMv8eBtfldr3FfniZQ2rEIB+sWeQlZNX?=
 =?iso-8859-1?Q?lTwuG3NaHYsPmjWphb+c2FCsCYgjkaRYWeckFAd/HzU/V5+Cn/fc3gteyj?=
 =?iso-8859-1?Q?/mSA=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e838114-9218-4390-0b40-08da39141e52
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:39.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh2GH8s2+4RaH5c0tMXXLj0gCEgjTuabiFo6QUsl13iB5g/D14AkHPjth4X5FFA4hQjtxgwgCAnriDQuWaFKfXmab4a6omW5EKTaHMtuNAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0575
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Can you do a job with me?
