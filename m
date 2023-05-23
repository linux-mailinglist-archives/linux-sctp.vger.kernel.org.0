Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D370DFA7
	for <lists+linux-sctp@lfdr.de>; Tue, 23 May 2023 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEWOt1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 May 2023 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjEWOt0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 May 2023 10:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFA18B;
        Tue, 23 May 2023 07:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B8B63356;
        Tue, 23 May 2023 14:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8529C433EF;
        Tue, 23 May 2023 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684853358;
        bh=oXOmFChpbfSn0ji1bqaSPr69srXCRms6pIPi5d3extM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RnJ/biP0CNt2CzSCbIf5AInpWLS2/o3mAdml1gU6P8dZI5Svc0H4Kg/0k6HUOTDPR
         eXUZo/gzxSjSCTyKGI7PT57SRJhvzT+4BdLb+ac5go6P2zZqw6FyoZcLzcV26wzAXr
         TraGlq925UBUqOYgnfGNx7VPx6BnP8mH6zk+aD0v5THCuz8GjPZh1ALYKHfSQ5MDu7
         W4xUR2+LIHBNTyaZSOTGH2VQEqWDITM1iHTMysKmRtyak4QwCnGE8EuynGMy3DZXmC
         hHvQ64sPkPACq17iIp/8wp82Oi9NPWG5kGwN//D8qEld7TVXT7H59Q7AEsE41qeXmV
         hcUwObqj4XWWA==
Message-ID: <2f02c9b6-1115-791d-cdaf-049c9eeaee0c@kernel.org>
Date:   Tue, 23 May 2023 08:49:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
        mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
References: <20230522134735.2810070-1-leitao@debian.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230522134735.2810070-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 5/22/23 7:47 AM, Breno Leitao wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..a2cea95aec99 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -114,6 +114,8 @@
>  #include <linux/memcontrol.h>
>  #include <linux/prefetch.h>
>  #include <linux/compat.h>
> +#include <linux/mroute.h>
> +#include <linux/mroute6.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -138,6 +140,7 @@
>  
>  #include <net/tcp.h>
>  #include <net/busy_poll.h>
> +#include <net/phonet/phonet.h>
>  
>  #include <linux/ethtool.h>
>  
> @@ -4106,3 +4109,112 @@ int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len)
>  	return sk->sk_prot->bind_add(sk, addr, addr_len);
>  }
>  EXPORT_SYMBOL(sock_bind_add);
> +
> +#ifdef CONFIG_PHONET
> +/* Copy u32 value from userspace and do not return anything back */
> +static int sk_ioctl_in(struct sock *sk, unsigned int cmd, void __user *arg)
> +{
> +	int karg;
> +
> +	if (get_user(karg, (u32 __user *)arg))
> +		return -EFAULT;
> +
> +	return sk->sk_prot->ioctl(sk, cmd, &karg);
> +}
> +#endif
> +
> +#if defined(CONFIG_IP_MROUTE) || defined(CONFIG_IPV6_MROUTE)
> +/* Copy 'size' bytes from userspace and return `size` back to userspace */
> +static int sk_ioctl_inout(struct sock *sk, unsigned int cmd,
> +			  void __user *arg, void *karg, size_t size)
> +{
> +	int ret;
> +
> +	if (copy_from_user(karg, arg, size))
> +		return -EFAULT;
> +
> +	ret = sk->sk_prot->ioctl(sk, cmd, karg);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(arg, karg, size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif
> +
> +/* This is the most common ioctl prep function, where the result (4 bytes) is
> + * copied back to userspace if the ioctl() returns successfully. No input is
> + * copied from userspace as input argument.
> + */
> +static int sk_ioctl_out(struct sock *sk, unsigned int cmd, void __user *arg)
> +{
> +	int ret, karg = 0;
> +
> +	ret = sk->sk_prot->ioctl(sk, cmd, &karg);
> +	if (ret)
> +		return ret;
> +
> +	return put_user(karg, (int __user *)arg);
> +}
> +
> +/* A wrapper around sock ioctls, which copies the data from userspace
> + * (depending on the protocol/ioctl), and copies back the result to userspace.
> + * The main motivation for this function is to pass kernel memory to the
> + * protocol ioctl callbacks, instead of userspace memory.
> + */
> +int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> +{
> +#ifdef CONFIG_IP_MROUTE
> +	if (sk->sk_family == PF_INET && sk->sk_protocol == IPPROTO_RAW) {
> +		switch (cmd) {
> +		/* These userspace buffers will be consumed by ipmr_ioctl() */
> +		case SIOCGETVIFCNT: {
> +			struct sioc_vif_req buffer;
> +
> +			return sk_ioctl_inout(sk, cmd, arg, &buffer,
> +					      sizeof(buffer));
> +			}
> +		case SIOCGETSGCNT: {
> +			struct sioc_sg_req buffer;
> +
> +			return sk_ioctl_inout(sk, cmd, arg, &buffer,
> +					      sizeof(buffer));
> +			}
> +		}
> +	}
> +#endif
> +#ifdef CONFIG_IPV6_MROUTE
> +	if (sk->sk_family == PF_INET6 && sk->sk_protocol == IPPROTO_RAW) {
> +		switch (cmd) {
> +		/* These userspace buffers will be consumed by ip6mr_ioctl() */
> +		case SIOCGETMIFCNT_IN6: {
> +			struct sioc_mif_req6 buffer;
> +
> +			return sk_ioctl_inout(sk, cmd, arg, &buffer,
> +					      sizeof(buffer));
> +			}
> +		case SIOCGETSGCNT_IN6: {
> +			struct sioc_mif_req6 buffer;
> +
> +			return sk_ioctl_inout(sk, cmd, arg, &buffer,
> +					      sizeof(buffer));
> +			}
> +		}
> +	}
> +#endif
> +#ifdef CONFIG_PHONET
> +	if (sk->sk_family == PF_PHONET && sk->sk_protocol == PN_PROTO_PHONET) {
> +		/* This userspace buffers will be consumed by pn_ioctl() */
> +		switch (cmd) {
> +		case SIOCPNADDRESOURCE:
> +		case SIOCPNDELRESOURCE:
> +			return sk_ioctl_in(sk, cmd, arg);
> +		}
> +	}
> +#endif

Rather than bleed some of these protocol specific details into core
code, how about something like this in include net/phonet/phonet.h

static inline bool sk_is_phonet(struct sock *sk)
{
	return sk->sk_family == PF_PHONET && \
		sk->sk_protocol == PN_PROTO_PHONET;
}

And then in net/core/sock.c:

	if (sk_is_phonet(sk)) {
		rc = phonet_sk_ioctl(...);
		if (rc <= 0)
			return rc;
	}

where < 0 means error, == 0 means handled and > 0 means (keep going).
Similarly for the other 2 above.

