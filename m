Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02C669949A
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Feb 2023 13:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPMnN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 16 Feb 2023 07:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBPMnJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Feb 2023 07:43:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05ED26A9
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 04:43:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-273-r-RoR-voMAm_uu3A0gg4iQ-1; Thu, 16 Feb 2023 12:43:02 +0000
X-MC-Unique: r-RoR-voMAm_uu3A0gg4iQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 16 Feb
 2023 12:43:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 16 Feb 2023 12:43:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qiumiao Zhang' <zhangqiumiao1@huawei.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>
CC:     "zhaowei23@huawei.com" <zhaowei23@huawei.com>,
        "caowangbao@huawei.com" <caowangbao@huawei.com>,
        "yanan@huawei.com" <yanan@huawei.com>
Subject: RE: [PATCH lksctp-tools 1/5] fix memory leak in sctp_status
Thread-Topic: [PATCH lksctp-tools 1/5] fix memory leak in sctp_status
Thread-Index: AQHZQfybv2qVH0PfbUaBG7G0ncDR0q7RhCeg
Date:   Thu, 16 Feb 2023 12:43:00 +0000
Message-ID: <e34861ea17504d11aab77ca18da20d96@AcuMS.aculab.com>
References: <20230216114822.1000-1-zhangqiumiao1@huawei.com>
 <20230216114822.1000-2-zhangqiumiao1@huawei.com>
In-Reply-To: <20230216114822.1000-2-zhangqiumiao1@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Freeing memory before exit() is a waste of time.

(and don't talk to me about calling C++ destructors)

	David

> -----Original Message-----
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> Sent: 16 February 2023 11:48
> To: linux-sctp@vger.kernel.org; marcelo.leitner@gmail.com
> Cc: zhaowei23@huawei.com; caowangbao@huawei.com; yanan@huawei.com; zhangqiumiao1@huawei.com
> Subject: [PATCH lksctp-tools 1/5] fix memory leak in sctp_status
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
>  src/apps/sctp_status.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/src/apps/sctp_status.c b/src/apps/sctp_status.c
> index 7c18ab1..5a52165 100644
> --- a/src/apps/sctp_status.c
> +++ b/src/apps/sctp_status.c
> @@ -266,6 +266,7 @@ int main(int argc, char *argv[]) {
>  		}
>  		if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
>  			fprintf(stderr, "\n*** serv_s malloc failed!!! ***\n");
> +			free(host_s);
>  			exit(1);
>  		}
> 
> @@ -273,6 +274,8 @@ int main(int argc, char *argv[]) {
>  		if (error) {
>  			printf("%s.\n", gai_strerror(error));
>  			usage(argv[0]);
> +			free(host_s);
> +			free(serv_s);
>  			exit(1);
>  		}
> 
> @@ -315,6 +318,8 @@ int main(int argc, char *argv[]) {
>  			    host_s, serv_s, res->ai_family);
> 
>  		freeaddrinfo(res);
> +		free(host_s);
> +		free(serv_s);
>          }
> 
>  	if (local_host != NULL) {
> @@ -330,6 +335,7 @@ int main(int argc, char *argv[]) {
>  		}
>  		if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
>  			fprintf(stderr, "\n*** serv_s malloc failed!!! ***\n");
> +			free(host_s);
>  			exit(1);
>  		}
> 
> @@ -340,6 +346,8 @@ int main(int argc, char *argv[]) {
>  		if (error) {
>  			printf("%s.\n", gai_strerror(error));
>  			usage(argv[0]);
> +			free(host_s);
> +			free(serv_s);
>  			exit(1);
>  		}
> 
> @@ -385,6 +393,8 @@ int main(int argc, char *argv[]) {
>  			    host_s, serv_s, res->ai_family);
> 
>  		freeaddrinfo(res);
> +		free(host_s);
> +		free(serv_s);
>          }
> 
>  	/* Let the testing begin. */
> @@ -403,6 +413,7 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
>  	}
>  	if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
>  		fprintf(stderr, "\n\t\t*** serv_s malloc failed!!! ***\n");
> +		free(host_s);
>  		exit(1);
>  	}
> 
> @@ -427,6 +438,8 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
>  				fprintf(stderr, "\n\n\t\t***bind: can "
>  					"not bind to %s:%s: %s ****\n",
>  					host_s, serv_s, strerror(errno));
> +				free(host_s);
> +				free(serv_s);
>  				exit(1);
>  			}
>  		}
> @@ -434,6 +447,8 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
>  		if (i >= MAX_BIND_RETRYS) {
>  			fprintf(stderr, "Maximum bind() attempts. "
>  				"Die now...\n\n");
> +			free(host_s);
> +			free(serv_s);
>  			exit(1);
>  		}
>  	} while (error < 0 && i < MAX_BIND_RETRYS);
> --
> 2.27.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

