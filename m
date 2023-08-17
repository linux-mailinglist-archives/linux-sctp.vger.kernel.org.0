Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21D77FD80
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Aug 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354247AbjHQSFL (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Aug 2023 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354231AbjHQSFA (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Aug 2023 14:05:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F0273C;
        Thu, 17 Aug 2023 11:04:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bba7717d3bso5771206fac.1;
        Thu, 17 Aug 2023 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692295497; x=1692900297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaFlLMUkgDXjGVWrM6IMPLCWNafFH2Z2cRH1t42kOXo=;
        b=felDi4nQWlL8mZyo5zdcArWXov68g+JtjrpASHxx0I0jbgtcjrhZ06SAchxM4WGBPM
         N57J+RyUxjhzQ5WRYEBnG0Xy3/4WtuDhQueWPX3SI5faqBh0KJbPfjWk84i/H4xhAqHa
         2AMQAAesRgAEHYLoS4N22g4m+I2ZGYiJfV2nzcPLbucxxkdIUvB+2QjXoAohQUlzrnqY
         8GDDW5oRLu74mGnCDM8JICurISFD2IlYFk68NUFe2J0G5a+wk7Sac6SyYM+NCWW4L28q
         Er9wnyf69nwlfLQ79uAVxA+p1s+POZozaZFDNFqUDgClSQ4YUM5+NxGoQTAj6P8X0Qc8
         FVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295497; x=1692900297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaFlLMUkgDXjGVWrM6IMPLCWNafFH2Z2cRH1t42kOXo=;
        b=l2jUcyopOJrDc5LQ9HB11W7Prrzc+zZbNVB9Kw7/jnoLUGx2Xn6p9XIzXTmxQ1Hwey
         WfofQz6t0tUoty+reejE5fk4AyER0gKG3T1fxAoZn05a8c/1B4ceYXnNdR5SfjBFF3Kh
         b26hHYpgT26ezU+I36ry+MM3QW/ZU1wBY3j+haZTVrlIdv+uHUDJJKgbLME/A8L/wlmu
         MnHx7YnoCPQDsOHQiNN8TrTrLh6cNVdO1cSL+eU7viokJM14FCy0u2eeVTmS/ZhmjTfR
         em2WMYr+ELJDw5FeVuvndghq8V95blahEfMSWlhQfStC2KP8nxe4v0zmoB61a5Cf3wfV
         6Y1w==
X-Gm-Message-State: AOJu0YxosNReG5iOGBRWS8nQjiYBB7gEH5+78y37TQHepY/j3n5UivAj
        qzhCP8XtNc7dnHOQ2oclj8zhSAchCknZu57P
X-Google-Smtp-Source: AGHT+IG7XKzmhtjJcFe2XNUBnqrlQmkmBngWWXhZhvSeGfnkxoPJjTGpQPWOk+J1D/zK7nErhEO/SQ==
X-Received: by 2002:a05:6870:a196:b0:1b7:3fd5:87cd with SMTP id a22-20020a056870a19600b001b73fd587cdmr155579oaf.48.1692295496972;
        Thu, 17 Aug 2023 11:04:56 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f508:4042:ec37:326f:3dcd:fbfa])
        by smtp.gmail.com with ESMTPSA id h17-20020a9d6a51000000b006af7580c84csm90321otn.60.2023.08.17.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:04:56 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 937047339AC; Thu, 17 Aug 2023 15:04:54 -0300 (-03)
Date:   Thu, 17 Aug 2023 15:04:54 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Simon Horman <horms@kernel.org>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: Re: [PATCHv2 nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
Message-ID: <ycoqoxkqgbhyudvhufzghix77yxymx6fdwccxltpo4vm7uvi6y@i4rak7os5des>
References: <4f2f3f3e0402c41ed46483dc9254dc6d71f06ceb.1692122927.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2f3f3e0402c41ed46483dc9254dc6d71f06ceb.1692122927.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 15, 2023 at 02:08:47PM -0400, Xin Long wrote:
...
> Note that the very short time value for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV
> was probably used for a rare scenario where SHUTDOWN is sent on 1st path
> but SHUTDOWN_ACK is replied on 2nd path, then a new connection started
> immediately on 1st path. So this patch also moves from SHUTDOWN_SEND/RECV
> to CLOSE when receiving INIT in the ORIGINAL direction.

Yeah.

> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> Reported-by: Paolo Valerio <pvalerio@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
