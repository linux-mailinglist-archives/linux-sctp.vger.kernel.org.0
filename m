Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446BA70A4FB
	for <lists+linux-sctp@lfdr.de>; Sat, 20 May 2023 05:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjETDuj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 23:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjETDuj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 23:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F21AC;
        Fri, 19 May 2023 20:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45AEF60D36;
        Sat, 20 May 2023 03:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA4C433EF;
        Sat, 20 May 2023 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684554636;
        bh=7gbdOBvoubtVGsMnX7VrvFV+k1lz+2s/iUuXnAd/aCk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gFQGZQzrT4E+c674LllbDACRPlLS/xQYPbM2g2mFLk3FS+i6jXI0qJhDrrJN7qu7R
         FJMBI7Y/6gSagf/Nx4UaLOIN1NTpqxG5Yuy81b1pWDCpirJ/cHbkUqgGVWHEpVuNg3
         dvZ533mkeoDDJlcxxTZKuGQafjZoialQDnZxCIdr7pdheg7fYBxzk95gCNXKwmOnrF
         93mu+mgxXONmSzifVbGKu6EbBl8qmPxM61/9nVrbZchRTENnkS77SdnxnxI3kxAUrN
         qHjCjfBJbBTTE6harqHqvLGPjce/8GukbYexrIcZHmXaXPAStRaedjhfyQUdTVNMDu
         /9tL32eEd6I7Q==
Message-ID: <e5a3b404-b958-c833-1032-70c78e159940@kernel.org>
Date:   Fri, 19 May 2023 21:50:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, axboe@kernel.dk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        courmisch@gmail.com, nhorman@tuxdriver.com
Cc:     asml.silence@gmail.com, alex.aring@gmail.com, dccp@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
        matthieu.baerts@tessares.net, marcelo.leitner@gmail.com,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        leit@fb.com, David.Laight@ACULAB.COM
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519135821.922326-2-leitao@debian.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230519135821.922326-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 5/19/23 7:58 AM, Breno Leitao wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..47567909baf2 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -4106,3 +4109,107 @@ int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len)
>  	return sk->sk_prot->bind_add(sk, addr, addr_len);
>  }
>  EXPORT_SYMBOL(sock_bind_add);
> +
> +/* Copy 'size' bytes from userspace and do not copy anything back */
> +int sock_skproto_ioctl_in(struct sock *sk, unsigned int cmd,
> +			  void __user *arg)

Unless I missed a reference, this one, the _inout, and the _out below
can be marked static - they are not need outside of sock.c.


> +{
> +	int karg;
> +
> +	if (get_user(karg, (u32 __user *)arg))
> +		return -EFAULT;
> +
> +	return sk->sk_prot->ioctl(sk, cmd, &karg);
> +}
> +
> +/* Copy 'size' bytes from userspace and return `size` back to userspace */
> +int sock_skproto_ioctl_inout(struct sock *sk, unsigned int cmd,
> +			     void __user *arg, size_t size)
> +{
> +	void *ptr;
> +	int ret;
> +
> +	ptr = kmalloc(size, GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(ptr, arg, size)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	ret = sk->sk_prot->ioctl(sk, cmd, ptr);
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(arg, ptr, size))
> +		ret = -EFAULT;
> +
> +out:
> +	kfree(ptr);
> +	return ret;
> +}
> +
> +/* This is the most common ioctl prep function, where the result (4 bytes) is
> + * copied back to userspace if the ioctl() returns successfully. No input is
> + * copied from userspace as input argument.
> + */
> +int sock_skproto_ioctl_out(struct sock *sk, unsigned int cmd,
> +			   void __user *arg)
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
> + * protocol ioctl callsback, instead of userspace memory.
> + */
> +int sock_skprot_ioctl(struct sock *sk, unsigned int cmd,
> +		      void __user *arg)
> +{
> +#ifdef CONFIG_IP_MROUTE
> +	if (!strcmp(sk->sk_prot->name, "RAW")) {
> +		switch (cmd) {
> +		/* These userspace buffers will be consumed by ipmr_ioctl() */
> +		case SIOCGETVIFCNT:
> +			return sock_skproto_ioctl_inout(sk, cmd,
> +				arg, sizeof(struct sioc_vif_req));
> +		case SIOCGETSGCNT:
> +			return sock_skproto_ioctl_inout(sk, cmd,
> +				arg, sizeof(struct sioc_sg_req));
> +		}
> +	}
> +#endif
> +#ifdef CONFIG_IPV6_MROUTE
> +	if (!strcmp(sk->sk_prot->name, "RAW6")) {
> +		switch (cmd) {
> +		/* These userspace buffers will be consumed by ip6mr_ioctl() */
> +		case SIOCGETMIFCNT_IN6:
> +			return sock_skproto_ioctl_inout(sk, cmd,
> +				arg, sizeof(struct sioc_mif_req6));
> +		case SIOCGETSGCNT_IN6:
> +			return sock_skproto_ioctl_inout(sk, cmd,
> +				arg, sizeof(struct sioc_sg_req6));
> +		}
> +	}
> +#endif
> +#ifdef CONFIG_PHONET
> +	if (!strcmp(sk->sk_prot->name, "PHONET")) {
> +		/* This userspace buffers will be consumed by pn_ioctl() */
> +		switch (cmd) {
> +		case SIOCPNADDRESOURCE:
> +		case SIOCPNDELRESOURCE:
> +			return sock_skproto_ioctl_in(sk, cmd, arg);
> +		}
> +	}
> +#endif
> +
> +	return sock_skproto_ioctl_out(sk, cmd, arg);
> +}


